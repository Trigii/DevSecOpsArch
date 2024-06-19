output "name" {
  description = "Specifies the name of the key vault"
  value       = azurerm_key_vault.tfg-devsecops-pro.name
}

output "id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.tfg-devsecops-pro.id
}

output "vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets"
  value       = azurerm_key_vault.tfg-devsecops-pro.vault_uri
}

output "client_id" {
  description = "Specifies the Azure Client ID (Application Object ID)"
  value       = data.azurerm_client_config.client_config.client_id
}

output "tenant_id" {
  description = "Specifies the Azure Tenant ID"
  value       = data.azurerm_client_config.client_config.tenant_id
}

output "subscription_id" {
  description = "Specifies the Azure Subscription ID"
  value       = data.azurerm_client_config.client_config.subscription_id
}