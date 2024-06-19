# We define al the variables needed

#################################### RESOURCE GROUP ####################################
variable "rg_principal_name" {
  type        = string
  description = "principal RG that contains the principal resources and services from Azure"
}

variable "location" {
  type        = string
  description = "resources location in Azure"
}
#########################################################################################

#################################### STORAGE ACCOUNT ####################################
variable "sa_name" {
  type        = string
  description = "Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group"
}

variable "sa_account_tier" {
  type        = string
  description = ""
}

variable "sa_account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2"
}

variable "sa_account_replication_type" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created"
}

variable "sa_is_hns_enabled" {
  type        = bool
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2"
}

variable "sa_default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow"
}

variable "sa_container_access_type" {
  type        = string
  description = "The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private"
}
######################################################################################

#################################### NETWORK SECURITY GROUP & RULES ####################################
variable "nsg_name" {
  type        = string
  description = "Specifies the name of the network security group. Changing this forces a new resource to be created"
}

variable "nsg_nsr_name" {
  type        = string
  description = "The name of the security rule. This needs to be unique across all Rules in the Network Security Group. Changing this forces a new resource to be created"
}
########################################################################################################

#################################### NETWORK WATCHER FLOG LOG ####################################
variable "nw_name" {
  type        = string
  description = "The name of the Network Watcher. Changing this forces a new resource to be created"
}

variable "la_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace. Workspace name should include 4-63 letters, digits or '-'"
}

variable "la_sku" {
  type        = string
  description = "Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018"
}

variable "nwfl_name" {
  type        = string
  description = "The name of the Network Watcher Flow Log. Changing this forces a new resource to be created"
}

variable "nwfl_enabled" {
  type        = bool
  description = "Should Network Flow Logging be Enabled?"
}

variable "nwfl_rp_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable retention"
}

variable "nwfl_rp_days" {
  type        = number
  description = "The number of days to retain flow log records"
}

variable "nwfl_ta_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable traffic analytics"
}

variable "nwfl_ta_interval" {
  type        = number
  description = "How frequently service should do flow analytics in minutes. Defaults to 60"
}
##################################################################################################

#################################### ROUTE TABLE ####################################
variable "rt_name" {
  type        = string
  description = "The name of the route table. Changing this forces a new resource to be created"
}

variable "route_name" {
  type        = string
  description = "The name of the route. Changing this forces a new resource to be created"
}

variable "vm_route_address_prefix" {
  type        = string
  description = "The destination to which the route applies. Can be CIDR (such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format"
}

variable "vm_route_next_hop_type" {
  type        = string
  description = "The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None"
}

variable "default_route_address_prefix" {
  type        = string
  description = "The destination to which the route applies. Can be CIDR (such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format"
}

variable "default_route_next_hop_type" {
  type        = string
  description = "The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None"
}
#####################################################################################

#################################### FIREWALL ####################################
variable "public_ip_name" {
  type        = string
  description = "Specifies the name of the Public IP. Changing this forces a new Public IP to be created"
}

variable "allocation_method" {
  type        = string
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic"
}

variable "sku" {
  type        = string
  description = "firewall sku"
}

variable "fw_name" {
  type        = string
  description = "Specifies the name of the Firewall. Changing this forces a new resource to be created"
}

variable "fw_sku_name" {
  type        = string
  description = "SKU name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet. Changing this forces a new resource to be created."
}

variable "fw_sku_tier" {
  type        = string
  description = "SKU tier of the Firewall. Possible values are Premium, Standard and Basic"
}

variable "ip_config_name" {
  type        = string
  description = "Specifies the name of the IP Configuration"
}
##################################################################################

#################################### VIRTUAL NETWORK ####################################
variable "vnet_name" {
  type        = string
  description = "The name of the virtual network. Changing this forces a new resource to be created"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network. You can supply more than one address space"
}

variable "firewall_subnet_name" {
  type        = string
  description = "The name of the firewall subnet"
}

variable "firewall_address_prefix" {
  type        = list(string)
  description = "The address prefix to use for the firewall subnet"
}

variable "bastion_subnet_name" {
  type        = string
  description = "The name of the bastion subnet"
}

variable "bastion_address_prefix" {
  type        = list(string)
  description = "The address prefix to use for the bastion subnet"
}

variable "aks_subnet_name_1" {
  type        = string
  description = "The name of the kubernetes service subnet 1"
}

variable "aks_address_prefix_1" {
  type        = list(string)
  description = "The address prefix to use for the kubernetes service subnet 1"
}

variable "aks_subnet_name_2" {
  type        = string
  description = "The name of the kubernetes service subnet 2"
}

variable "aks_address_prefix_2" {
  type        = list(string)
  description = "The address prefix to use for the kubernetes service subnet 2"
}
#########################################################################################

#################################### CONTAINER REGISTRY ####################################
variable "acr_name" {
  type        = string
  description = "Specifies the name of the Container Registry. Only Alphanumeric characters allowed. Changing this forces a new resource to be created"
}

variable "acr_sku" {
  type        = string
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium"
}

variable "acr_admin_enabled" {
  type        = bool
  description = "Specifies whether the admin user is enabled. Defaults to false"
}
#########################################################################################

#################################### KEY VAULT ####################################
variable "kv_name" {
  type        = string
  description = "Specifies the name of the Key Vault. Changing this forces a new resource to be created. The name must be globally unique. If the vault is in a recoverable state then the vault will need to be purged before reusing the name"
}

variable "kv_sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"
}

variable "kv_bypass" {
  type        = string
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None"
}

variable "kv_default_action" {
  type        = string
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny"
}
###################################################################################

#################################### VIRTUAL MACHINE (BASTION) ####################################
variable "vm_public_ip_name" {
  type        = string
  description = "Specifies the name of the Public IP. Changing this forces a new Public IP to be created"
}

variable "vm_allocation_method" {
  type        = string
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic"
}

variable "vm_sku" {
  type        = string
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. Changing this forces a new resource to be created"
}

variable "vm_nic_name" {
  type        = string
  description = "The name of the Network Interface. Changing this forces a new resource to be created"
}

variable "vm_nic_private_ip_address_allocation" {
  type        = string
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static"
}

variable "vm_nic_private_ip_address" {
  type        = string
  description = "The Static IP Address which should be used"
}

variable "vm_tls_private_key_algorithm" {
  type        = string
  description = "Name of the algorithm to use when generating the private key. Currently-supported values are: RSA, ECDSA, ED25519"
}

variable "vm_tls_private_key_rsa_bits" {
  type        = number
  description = "When algorithm is RSA, the size of the generated RSA key, in bits (default: 2048)"
}

variable "vm_name" {
  type        = string
  description = "The name of the Linux Virtual Machine. Changing this forces a new resource to be created"
}

variable "vm_size" {
  type        = string
  description = "The SKU which should be used for this Virtual Machine, such as Standard_F2"
}

variable "vm_admin_username" {
  type        = string
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created"
}

variable "vm_os_disk_caching" {
  type        = string
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite"
}

variable "vm_os_disk_sorage_account_type" {
  type        = string
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created"
}

variable "vm_source_image_reference_publisher" {
  type        = string
  description = "Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created"
}

variable "vm_source_image_reference_offer" {
  type        = string
  description = "Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created"
}

variable "vm_source_image_reference_sku" {
  type        = string
  description = "Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created"
}

variable "vm_source_image_reference_version" {
  type        = string
  description = "Specifies the version of the image used to create the virtual machines. Changing this forces a new resource to be created"
}
#########################################################################################

#################################### AKS CLUSTER ####################################
variable "aks_tls_private_key_algorithm" {
  type        = string
  description = "Name of the algorithm to use when generating the private key. Currently-supported values are: RSA, ECDSA, ED25519"
}

variable "aks_tls_private_key_rsa_bits" {
  type        = number
  description = "When algorithm is RSA, the size of the generated RSA key, in bits (default: 2048)"
}

variable "aks_name" {
  type        = string
  description = "The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created"
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created"
}

variable "aks_private_cluster_enabled" {
  type        = bool
  description = "This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created"
}

variable "aks_automatic_channel_upgrade" {
  type        = string
  description = "The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none"
}

variable "aks_sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free"
}

variable "aks_default_node_pool_name" {
  type        = string
  description = "The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created"
}

variable "aks_default_node_pool_vm_size" {
  type        = string
  description = "The size of the Virtual Machine, such as Standard_DS2_v2. Changing this forces a new resource to be created"
}

variable "aks_default_node_pool_node_labels" {
  type        = map(any)
  description = "A map of Kubernetes labels which should be applied to nodes in the Default Node Pool"
}

variable "aks_default_node_pool_node_taints" {
  type        = list(string)
  description = "A list of the taints added to new nodes during node pool create and scale. Changing this forces a new resource to be created"
}

variable "aks_default_node_pool_enable_auto_scaling" {
  type        = bool
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool?"
}

variable "aks_default_node_pool_enable_host_encryption" {
  type        = bool
  description = "Should the nodes in the Default Node Pool have host encryption enabled? Changing this forces a new resource to be created"
}

variable "aks_default_node_pool_enable_node_public_ip" {
  type        = bool
  description = "Should nodes in this Node Pool have a Public IP Address? Changing this forces a new resource to be created"
}

variable "aks_default_node_pool_max_pods" {
  type        = number
  description = "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created"
}

variable "aks_default_node_pool_max_count" {
  type        = number
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
}

variable "aks_default_node_pool_min_count" {
  type        = number
  description = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
}

variable "aks_default_node_pool_node_count" {
  type        = number
  description = "The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count"
}

variable "aks_default_node_pool_os_disk_type" {
  type        = string
  description = "The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created"
}

variable "aks_admin_username" {
  type        = string
  description = "The Admin Username for the Cluster. Changing this forces a new resource to be created"
}

variable "aks_network_docker_bridge_cidr" {
  type        = string
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created"
}

variable "aks_network_dns_service_ip" {
  type        = string
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created"
}

variable "aks_network_plugin" {
  type        = string
  description = "Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created"
}

variable "aks_network_service_cidr" {
  type        = string
  description = "The Network Range used by the Kubernetes service. Changing this forces a new resource to be created"
}
#####################################################################################