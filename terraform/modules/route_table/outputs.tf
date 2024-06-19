output "aks_route_table_id" {
  description = "The Route Table ID"
  value       = azurerm_route_table.aks_route_table.id
}

output "vm_route_table_id" {
  description = "The Route Table ID"
  value       = azurerm_route_table.vm_route_table.id
}