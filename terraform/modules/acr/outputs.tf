output "name" {
  description = "Specifies the name of the container registry"
  value       = azurerm_container_registry.tfg-devsecops-pro.name
}

output "id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.tfg-devsecops-pro.id
}

output "login_server" {
  description = "The URL that can be used to log into the container registry"
  value       = azurerm_container_registry.tfg-devsecops-pro.login_server
}

output "admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled"
  value       = azurerm_container_registry.tfg-devsecops-pro.admin_username
}

output "admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled"
  value       = azurerm_container_registry.tfg-devsecops-pro.admin_password
}