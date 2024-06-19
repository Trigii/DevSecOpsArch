############################# VIRTUAL NETWORK #############################
variable "vnet_name" {
  type        = string
  description = "The name of the virtual network. Changing this forces a new resource to be created"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network. You can supply more than one address space"
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

############################# SUBNETS #############################
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