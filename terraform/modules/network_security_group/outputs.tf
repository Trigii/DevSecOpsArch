output "nsg_id" {
  description = "The ID of the VM Network Security Group"
  value       = azurerm_network_security_group.nsg.id
}

output "nsg_2_id" {
  description = "The ID of the AKS Network Security Group"
  value       = azurerm_network_security_group.nsg-2.id
}