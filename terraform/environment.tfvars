# We store the real values in the variables of variables.tf

#################################### RESOURCE GROUP ####################################
rg_principal_name = "main-tfg-devsecops"
location          = "West Europe"
########################################################################################

#################################### STORAGE ACCOUNT ####################################
sa_name                     = "tfgstorageaccount"
sa_account_tier             = "Standard"
sa_account_kind             = "StorageV2"
sa_account_replication_type = "LRS"
sa_is_hns_enabled           = false

sa_default_action = "Allow"

sa_container_access_type = "blob"
#########################################################################################

#################################### NETWORK SECURITY GROUP & RULES ####################################
nsg_name     = "tfg-nsg"
nsg_nsr_name = "tfg-vm-rule"
########################################################################################################

#################################### NETWORK WATCHER FLOG LOG ####################################
#nw_name = "tfg-network-watcher"
nw_name = "NetworkWatcher_westeurope"

la_name = "tfg-log-analytics"
la_sku  = "PerGB2018"

nwfl_name    = "tfg-network-watcher-flow-log"
nwfl_enabled = true

nwfl_rp_enabled = true
nwfl_rp_days    = 30

nwfl_ta_enabled  = true
nwfl_ta_interval = 10
##################################################################################################

#################################### ROUTE TABLE ####################################
rt_name = "tfg-route-table"
route_name = "tfg-route"

vm_route_address_prefix = "0.0.0.0/0"
vm_route_next_hop_type  = "VirtualAppliance"

default_route_address_prefix = "0.0.0.0/0"
default_route_next_hop_type  = "VirtualAppliance"
#####################################################################################

#################################### FIREWALL ####################################
public_ip_name    = "tfg-fw-public-ip"
allocation_method = "Static"
sku               = "Standard"

fw_name        = "tfg-firewall"
fw_sku_name    = "AZFW_VNet"
fw_sku_tier    = "Standard"
ip_config_name = "tfg-firewall-ip-configuration"
########################################################################################

#################################### VIRTUAL NETWORK ####################################
vnet_name          = "tfg-vnet"
vnet_address_space = ["142.10.0.0/16"]

firewall_subnet_name    = "AzureFirewallSubnet"
firewall_address_prefix = ["142.10.96.0/24"]

bastion_subnet_name    = "tfg-devsecops-pro-bastion"
bastion_address_prefix = ["142.10.32.0/20"]

aks_subnet_name_1    = "tfg-devsecops-pro-01"
aks_address_prefix_1 = ["142.10.0.0/20"]

aks_subnet_name_2    = "tfg-devsecops-pro-02"
aks_address_prefix_2 = ["142.10.16.0/20"]
########################################################################################

#################################### CONTAINER REGISTRY ####################################
acr_name          = "tfgACR"
acr_sku           = "Basic"
acr_admin_enabled = true
############################################################################################

#################################### KEY VAULT ####################################
kv_name           = "tfg-devsecops-pro"
kv_sku_name       = "standard"
kv_bypass         = "AzureServices"
kv_default_action = "Allow"
###################################################################################

#################################### VIRTUAL MACHINE (BASTION) ####################################
vm_public_ip_name    = "tfg-vm-public-ip"
vm_allocation_method = "Static"
vm_sku               = "Standard"

vm_nic_name                          = "tfg-vm-nic"
vm_nic_private_ip_address_allocation = "Static"
vm_nic_private_ip_address            = "142.10.32.4"


vm_tls_private_key_algorithm = "RSA"
vm_tls_private_key_rsa_bits  = 4096

vm_name                             = "tfg-devsecops-bastion"
vm_size                             = "Standard_DS1_v2" # "Standard_B2s"
vm_admin_username                   = "tfgadmin"
vm_os_disk_caching                  = "ReadWrite"
vm_os_disk_sorage_account_type      = "Standard_LRS"
vm_source_image_reference_publisher = "Canonical"
vm_source_image_reference_offer     = "UbuntuServer"
vm_source_image_reference_sku       = "18.04-LTS"
vm_source_image_reference_version   = "latest"
###################################################################################################

#################################### AKS CLUSTER ####################################
aks_tls_private_key_algorithm = "RSA"
aks_tls_private_key_rsa_bits  = 4096

aks_name                      = "tfg-devsecops-pro"
aks_dns_prefix                = "tfg-devsecops-pro-prefix"
aks_private_cluster_enabled   = true
aks_automatic_channel_upgrade = "stable"
aks_sku_tier                  = "Free"

aks_default_node_pool_name                   = "tfgnodepool"
aks_default_node_pool_vm_size                = "Standard_DS3_v2" # "Standard_F8s_v2"
aks_default_node_pool_node_labels            = {}
aks_default_node_pool_node_taints            = []
aks_default_node_pool_enable_auto_scaling    = true
aks_default_node_pool_enable_host_encryption = false
aks_default_node_pool_enable_node_public_ip  = false
aks_default_node_pool_max_pods               = 30
aks_default_node_pool_max_count              = 3
aks_default_node_pool_min_count              = 1
aks_default_node_pool_node_count             = 1
aks_default_node_pool_os_disk_type           = "Ephemeral"

aks_admin_username = "tfgadmin"

aks_network_docker_bridge_cidr = "142.10.0.1/16"
aks_network_dns_service_ip     = "10.60.0.2"
aks_network_plugin             = "azure"
aks_network_service_cidr       = "10.60.0.0/24"
#####################################################################################