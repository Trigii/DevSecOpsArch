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

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vm_nic_name" {
  type        = string
  description = "The name of the Network Interface. Changing this forces a new resource to be created"
}

variable "vm_nic_subnet_id" {
  description = "Specifies the resource id of the subnet hosting the virtual machine"
}

variable "vm_nic_private_ip_address_allocation" {
  type        = string
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static"
}

variable "vm_nic_private_ip_address" {
  type        = string
  description = "The Static IP Address which should be used"
}

variable "vm_nic_nsg_id" {
  description = "The ID of the Network Security Group which should be attached to the Network Interface. Changing this forces a new resource to be created"
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