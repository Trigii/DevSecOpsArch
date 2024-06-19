output "id" {
  description = "The ID of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "private_ip_address" {
  description = "The Primary Private IP Address assigned to this Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "public_ip_address" {
  description = "The Primary Public IP Address assigned to this Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "virtual_machine_id" {
  description = "A 128-bit identifier which uniquely identifies this Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.virtual_machine_id
}

output "vm_user" {
  description = "Username of the Virtual Machine"
  value       = var.vm_admin_username
}

output "private_key_openssh" {
  description = "(String, Sensitive) Private key data in OpenSSH PEM (RFC 4716) format"
  value       = tls_private_key.private_key.private_key_openssh
  sensitive   = true
}

output "private_key_pem" {
  description = "(String, Sensitive) Private key data in PEM (RFC 1421) format"
  value       = tls_private_key.private_key.private_key_pem
  sensitive   = true
}