variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

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

variable "vm_route_next_hop_in_ip_address" {
  type        = string
  description = "Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance"
}

variable "default_route_address_prefix" {
  type        = string
  description = "The destination to which the route applies. Can be CIDR (such as 10.1.0.0/16) or Azure Service Tag (such as ApiManagement, AzureBackup or AzureMonitor) format"
}

variable "default_route_next_hop_type" {
  type        = string
  description = "The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None"
}

variable "default_route_next_hop_in_ip_address" {
  type        = string
  description = "Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance"
}

variable "vm_subnet_id" {
  description = "The ID of the Subnet. Changing this forces a new resource to be created"
}

variable "aks_subnet_id" {
  description = "The ID of the Subnet. Changing this forces a new resource to be created"
}

variable "aks_subnet_id_2" {
  description = "The ID of the Subnet. Changing this forces a new resource to be created"
}