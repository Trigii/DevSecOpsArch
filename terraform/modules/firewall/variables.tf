variable "public_ip_name" {
  type        = string
  description = "Specifies the name of the Public IP. Changing this forces a new Public IP to be created"
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "allocation_method" {
  type        = string
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic"
}

variable "fw_name" {
  type        = string
  description = "Specifies the name of the Firewall. Changing this forces a new resource to be created"
}

variable "sku" {
  type        = string
  description = "firewall sku"
}

variable "sku_name" {
  type        = string
  description = "SKU name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet. Changing this forces a new resource to be created."
}

variable "sku_tier" {
  description = "SKU tier of the Firewall. Possible values are Premium, Standard and Basic"
}

variable "ip_config_name" {
  type        = string
  description = "Specifies the name of the IP Configuration"
}

variable "subnet_id" {
  description = "Reference to the subnet associated with the IP Configuration. Changing this forces a new resource to be created"
}