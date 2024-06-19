variable "nsg_name" {
  type        = string
  description = "Specifies the name of the network security group. Changing this forces a new resource to be created"
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "nsg_nsr_name" {
  type        = string
  description = "The name of the security rule. This needs to be unique across all Rules in the Network Security Group. Changing this forces a new resource to be created"
}