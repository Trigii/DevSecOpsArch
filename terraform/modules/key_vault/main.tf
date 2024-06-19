data "azurerm_client_config" "client_config" {}

resource "azurerm_key_vault" "tfg-devsecops-pro" {
  name                     = var.kv_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = data.azurerm_client_config.client_config.tenant_id
  sku_name                 = var.kv_sku_name
  purge_protection_enabled = false

  access_policy = [{
    key_permissions         = ["Get"]
    object_id               = data.azurerm_client_config.client_config.client_id
    application_id          = data.azurerm_client_config.client_config.client_id
    certificate_permissions = [ "Backup", "Create", "Delete", "Get", "Import", "List", "Purge", "Recover", "Restore", "Update"]
    secret_permissions      = ["Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set"]
    storage_permissions     = ["Get"]
    tenant_id               = data.azurerm_client_config.client_config.tenant_id
  }]
  # revisar
  network_acls {
    bypass                     = var.kv_bypass
    default_action             = var.kv_default_action
    virtual_network_subnet_ids = [var.kv_subnet_id_1, var.kv_subnet_id_2]
  }
}