resource "azurerm_subnet_network_security_group_association" "subnet-nsg" {
  subnet_id                 = var.aks_default_node_pool_vnet_subnet_id
  network_security_group_id = var.aks_nsg_id
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg-2" {
  subnet_id                 = var.aks_default_node_pool_vnet_subnet_id_2
  network_security_group_id = var.aks_nsg_id
}

resource "tls_private_key" "private_key" {
  algorithm = var.aks_tls_private_key_algorithm
  rsa_bits  = var.aks_tls_private_key_rsa_bits
}

resource "local_sensitive_file" "ssh-private-key-local" {
  content         = tls_private_key.private_key.private_key_pem
  filename        = "${path.module}/../../private_keys/aks_private_key.pem"
  file_permission = "400"
  depends_on = [
    tls_private_key.private_key
  ]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                      = var.aks_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.aks_dns_prefix
  private_cluster_enabled   = var.aks_private_cluster_enabled
  automatic_channel_upgrade = var.aks_automatic_channel_upgrade
  sku_tier                  = var.aks_sku_tier

  default_node_pool {
    name                   = var.aks_default_node_pool_name
    vm_size                = var.aks_default_node_pool_vm_size
    node_labels            = var.aks_default_node_pool_node_labels
    node_taints            = var.aks_default_node_pool_node_taints
    enable_auto_scaling    = var.aks_default_node_pool_enable_auto_scaling
    enable_host_encryption = var.aks_default_node_pool_enable_host_encryption
    enable_node_public_ip  = var.aks_default_node_pool_enable_node_public_ip
    max_pods               = var.aks_default_node_pool_max_pods
    max_count              = var.aks_default_node_pool_max_count
    min_count              = var.aks_default_node_pool_min_count
    node_count             = var.aks_default_node_pool_node_count
    os_disk_type           = var.aks_default_node_pool_os_disk_type
    vnet_subnet_id         = var.aks_default_node_pool_vnet_subnet_id
  }

  linux_profile {
    admin_username = var.aks_admin_username
    ssh_key {
      key_data = tls_private_key.private_key.public_key_openssh
    }
  }

  service_principal {
    client_id     = "1c273964-47c3-49ec-a182-90a9cb549abd"
    client_secret = "BK88Q~1LhP.iEURtsQZh1wIWZlwsuJ34PwboLbnU"
  }

  network_profile {
    docker_bridge_cidr = var.aks_network_docker_bridge_cidr
    dns_service_ip     = var.aks_network_dns_service_ip
    network_plugin     = var.aks_network_plugin
    service_cidr       = var.aks_network_service_cidr
  }
}