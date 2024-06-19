# Defines the use of the main modules
############################# RESOURCE GROUP #############################
resource "azurerm_resource_group" "Main-tfg-devsecops-pro" {
  name     = var.rg_principal_name
  location = var.location
}
##########################################################################

############################# STORAGE ACCOUNT #############################
/*
module "azurerm_storage_account" {
  source = "./modules/storage_account"

  location            = var.location
  resource_group_name = var.rg_principal_name

  # storage account
  sa_name                     = var.sa_name
  sa_account_tier             = var.sa_account_tier
  sa_account_kind             = var.sa_account_kind
  sa_account_replication_type = var.sa_account_replication_type
  sa_is_hns_enabled           = var.sa_is_hns_enabled

  # sa netowrk rules
  sa_default_action = var.sa_default_action

  # sa container
  sa_container_access_type = var.sa_container_access_type
}
*/
###########################################################################

############################# NETWORK SECURITY GROUP & RULES #############################
module "azurerm_network_security_group" {
  source = "./modules/network_security_group"

  location            = var.location
  resource_group_name = var.rg_principal_name

  # Network Security Group
  nsg_name = var.nsg_name

  # Network Security Rule
  nsg_nsr_name = var.nsg_nsr_name

  depends_on = [ azurerm_resource_group.Main-tfg-devsecops-pro ]

}
##########################################################################################

############################# NETWORK WATCHER FLOG LOG #############################
/*
module "azurerm_network_watcher_flow_log" {
  source = "./modules/network_watcher_flow_log"

  location            = var.location
  resource_group_name = var.rg_principal_name

  # Network Watcher
  nw_name = var.nw_name

  # Log analytics workspace
  la_name = var.la_name
  la_sku  = var.la_sku

  # Network Watcher Flow Log
  nwfl_name     = var.nwfl_name
  nwfl_nsg_id_1 = module.azurerm_network_security_group.nsg_id
  nwfl_nsg_id_2 = module.azurerm_network_security_group.nsg_2_id
  nwfl_sa_id    = module.azurerm_storage_account.id
  nwfl_enabled  = var.nwfl_enabled

  # retention policy
  nwfl_rp_enabled = var.nwfl_rp_enabled
  nwfl_rp_days    = var.nwfl_rp_days

  # traffic analytics
  nwfl_ta_enabled  = var.nwfl_ta_enabled
  nwfl_ta_interval = var.nwfl_ta_interval

  depends_on = [
    module.azurerm_network_security_group, module.azurerm_storage_account
  ]
}
*/
#####################################################################################

############################# ROUTE TABLE #############################
module "azurerm_route_table" {
  source = "./modules/route_table"

  location            = var.location
  resource_group_name = var.rg_principal_name

  # route table
  rt_name = var.rt_name

  # route
  route_name = var.route_name

  # vm - internet route
  vm_route_address_prefix         = var.vm_route_address_prefix
  vm_route_next_hop_type          = var.vm_route_next_hop_type
  vm_route_next_hop_in_ip_address = module.azurerm_firewall.ip_configuration[0].private_ip_address

  # aks default route
  default_route_address_prefix         = var.default_route_address_prefix
  default_route_next_hop_type          = var.default_route_next_hop_type
  default_route_next_hop_in_ip_address = module.azurerm_firewall.ip_configuration[0].private_ip_address

  # vm rt association 
  vm_subnet_id = module.azurerm_virtual_network.bastion_subnet_id

  # aks rt association
  aks_subnet_id   = module.azurerm_virtual_network.aks_subnet_1_id
  aks_subnet_id_2 = module.azurerm_virtual_network.aks_subnet_2_id

  depends_on = [
    module.azurerm_firewall, module.azurerm_virtual_network
  ]
}
#######################################################################

############################# FIREWALL #############################
module "azurerm_firewall" {
  source = "./modules/firewall"

  location            = var.location
  resource_group_name = var.rg_principal_name

  # public ip
  public_ip_name    = var.public_ip_name
  allocation_method = var.allocation_method
  sku               = var.sku

  # firewall
  fw_name        = var.fw_name
  sku_name       = var.fw_sku_name
  sku_tier       = var.fw_sku_tier
  ip_config_name = var.ip_config_name
  subnet_id      = module.azurerm_virtual_network.firewall_subnet_id

  depends_on = [
    module.azurerm_virtual_network
  ]
}
####################################################################

############################# VIRTUAL NETWORK #############################
module "azurerm_virtual_network" {
  source = "./modules/virtual_network"

  location            = var.location
  resource_group_name = var.rg_principal_name

  # vnet
  vnet_name     = var.vnet_name
  address_space = var.vnet_address_space

  # firewall subnet
  firewall_subnet_name    = var.firewall_subnet_name
  firewall_address_prefix = var.firewall_address_prefix

  # bastion subnet (vm)
  bastion_subnet_name    = var.bastion_subnet_name
  bastion_address_prefix = var.bastion_address_prefix

  # tfg-devsecops-pro-01 subnet
  aks_subnet_name_1    = var.aks_subnet_name_1
  aks_address_prefix_1 = var.aks_address_prefix_1

  # tfg-devsecops-pro-02 subnet
  aks_subnet_name_2    = var.aks_subnet_name_2
  aks_address_prefix_2 = var.aks_address_prefix_2

  depends_on = [
   azurerm_resource_group.Main-tfg-devsecops-pro
  ]
}
##########################################################################

############################# CONTAINER REGISTRY #############################
module "azurerm_container_registry" {
  source = "./modules/acr"

  location            = var.location
  resource_group_name = var.rg_principal_name

  # acr
  acr_name          = var.acr_name
  acr_sku           = var.acr_sku
  acr_admin_enabled = var.acr_admin_enabled

  depends_on = [
   azurerm_resource_group.Main-tfg-devsecops-pro
  ]
}
##############################################################################

############################# KEY VAULT #############################
module "azurerm_key_vault" {
  source = "./modules/key_vault"
  
  location = var.location
  resource_group_name = var.rg_principal_name

  # key vault
  kv_name = var.kv_name
  kv_sku_name = var.kv_sku_name
  kv_bypass = var.kv_bypass
  kv_default_action = var.kv_default_action
  kv_subnet_id_1 = module.azurerm_virtual_network.aks_subnet_1_id
  kv_subnet_id_2 = module.azurerm_virtual_network.aks_subnet_2_id

  depends_on = [
    module.azurerm_virtual_network
  ]
}
#####################################################################

############################# VIRTUAL MACHINE (BASTION) #############################
module "azurerm_linux_virtual_machine" {
  source = "./modules/virtual_machine"

  # public_ip
  vm_public_ip_name    = var.vm_public_ip_name
  vm_allocation_method = var.vm_allocation_method
  vm_sku               = var.vm_sku

  location            = var.location
  resource_group_name = var.rg_principal_name

  # Network Interface
  vm_nic_name                          = var.vm_nic_name
  vm_nic_subnet_id                     = module.azurerm_virtual_network.bastion_subnet_id
  vm_nic_private_ip_address_allocation = var.vm_nic_private_ip_address_allocation
  vm_nic_private_ip_address            = var.vm_nic_private_ip_address

  # Network Interface security group association
  vm_nic_nsg_id = module.azurerm_network_security_group.nsg_id

  # ssh key
  vm_tls_private_key_algorithm = var.vm_tls_private_key_algorithm
  vm_tls_private_key_rsa_bits  = var.vm_tls_private_key_rsa_bits

  # VM variables
  vm_name           = var.vm_name
  vm_size           = var.vm_size
  vm_admin_username = var.vm_admin_username
  # vm_admin_ssh_public_key = var.vm_admin_ssh_public_key
  vm_os_disk_caching                  = var.vm_os_disk_caching
  vm_os_disk_sorage_account_type      = var.vm_os_disk_sorage_account_type
  vm_source_image_reference_publisher = var.vm_source_image_reference_publisher
  vm_source_image_reference_offer     = var.vm_source_image_reference_offer
  vm_source_image_reference_sku       = var.vm_source_image_reference_sku
  vm_source_image_reference_version   = var.vm_source_image_reference_version

  depends_on = [
    module.azurerm_virtual_network, module.azurerm_network_security_group
  ]
}
###########################################################################

############################# AKS CLUSTER #############################
module "azurerm_kubernetes_cluster" {
  source = "./modules/aks"

  location            = var.location
  resource_group_name = var.rg_principal_name

  # tls_private_key
  aks_tls_private_key_algorithm = var.aks_tls_private_key_algorithm
  aks_tls_private_key_rsa_bits  = var.aks_tls_private_key_rsa_bits

  # aks cluster
  aks_name                      = var.aks_name
  aks_dns_prefix                = var.aks_dns_prefix
  aks_private_cluster_enabled   = var.aks_private_cluster_enabled
  aks_automatic_channel_upgrade = var.aks_automatic_channel_upgrade
  aks_sku_tier                  = var.aks_sku_tier

  # default node pool
  aks_default_node_pool_name                   = var.aks_default_node_pool_name
  aks_default_node_pool_vm_size                = var.aks_default_node_pool_vm_size
  aks_default_node_pool_node_labels            = var.aks_default_node_pool_node_labels
  aks_default_node_pool_node_taints            = var.aks_default_node_pool_node_taints
  aks_default_node_pool_enable_auto_scaling    = var.aks_default_node_pool_enable_auto_scaling
  aks_default_node_pool_enable_host_encryption = var.aks_default_node_pool_enable_host_encryption
  aks_default_node_pool_enable_node_public_ip  = var.aks_default_node_pool_enable_node_public_ip
  aks_default_node_pool_max_pods               = var.aks_default_node_pool_max_pods
  aks_default_node_pool_max_count              = var.aks_default_node_pool_max_count
  aks_default_node_pool_min_count              = var.aks_default_node_pool_min_count
  aks_default_node_pool_node_count             = var.aks_default_node_pool_node_count
  aks_default_node_pool_os_disk_type           = var.aks_default_node_pool_os_disk_type

  # subnet-nsg association
  aks_default_node_pool_vnet_subnet_id   = module.azurerm_virtual_network.aks_subnet_1_id
  aks_default_node_pool_vnet_subnet_id_2 = module.azurerm_virtual_network.aks_subnet_2_id
  aks_nsg_id                             = module.azurerm_network_security_group.nsg_2_id

  # linux profile
  aks_admin_username = var.aks_admin_username

  # network profile
  aks_network_docker_bridge_cidr = var.aks_network_docker_bridge_cidr
  aks_network_dns_service_ip     = var.aks_network_dns_service_ip
  aks_network_plugin             = var.aks_network_plugin
  aks_network_service_cidr       = var.aks_network_service_cidr

  depends_on = [
    module.azurerm_virtual_network, module.azurerm_network_security_group
  ]
}
#######################################################################
