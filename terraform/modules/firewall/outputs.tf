output "ip_configuration" {
  description = "The Private IP address of the Azure Firewall"
  value       = azurerm_firewall.firewall.ip_configuration
}

output "firewall_public_ip" {
  description = "The public IP address from the firewall"
  value       = azurerm_public_ip.public_ip.ip_address
}