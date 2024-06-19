/*
variable "aks_user_assigned_name" {
  type = string
  description = "Specifies the name of this User Assigned Identity. Changing this forces a new User Assigned Identity to be created"
}
*/
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}
/*
variable "aks_acr_id" {
  description = "The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created"
}
*/
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

variable "aks_default_node_pool_vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created"
}

variable "aks_default_node_pool_vnet_subnet_id_2" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created"
}

variable "aks_nsg_id" {
  description = "The ID of the Network Security Group associated with the Kubernetes Cluster. Changing this forces a new resource to be created"
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