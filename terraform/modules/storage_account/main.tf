resource "azurerm_storage_account" "tfg-sa" {
  name                     = var.sa_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.sa_account_tier
  account_kind             = var.sa_account_kind
  account_replication_type = var.sa_account_replication_type
  is_hns_enabled           = var.sa_is_hns_enabled

  network_rules {
    default_action = var.sa_default_action
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "sa_container" {
  name                  = "${var.sa_name}-container"
  storage_account_name  = azurerm_storage_account.tfg-sa.name
  container_access_type = var.sa_container_access_type

  depends_on = [
    azurerm_storage_account.tfg-sa
  ]
}