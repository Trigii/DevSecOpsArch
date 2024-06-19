output "vnet_name" {
  description = "name of the virtual network"
  value       = azurerm_virtual_network.vnet-preprod-showcase.name
}

output "vnet_id" {
  description = "id of the virtual network"
  value       = azurerm_virtual_network.vnet-preprod-showcase.id
}

output "firewall_subnet_id" {
  description = "id of the firewall subnet"
  value       = azurerm_subnet.firewall_subnet.id
}

output "bastion_subnet_id" {
  description = "id of the bastion subnet"
  value       = azurerm_subnet.bastion_subnet.id
}

output "aks_subnet_1_id" {
  description = "id of the aks subnet 1"
  value       = azurerm_subnet.aks_subnet_1.id
}

output "aks_subnet_2_id" {
  description = "id of the aks subnet 2"
  value       = azurerm_subnet.aks_subnet_2.id
}