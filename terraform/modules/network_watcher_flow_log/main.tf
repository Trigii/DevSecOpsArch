/*
resource "azurerm_network_watcher" "nw" {
  name                = var.nw_name
  location            = var.location
  resource_group_name = var.resource_group_name
}
*/
resource "azurerm_log_analytics_workspace" "la" {
  name                = var.la_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.la_sku
}

resource "azurerm_network_watcher_flow_log" "nwfl" {
  network_watcher_name = var.nw_name
  resource_group_name  = "NetworkWatcherRG"
  name                 = "${var.nwfl_name}-vm"

  network_security_group_id = var.nwfl_nsg_id_1
  storage_account_id        = var.nwfl_sa_id
  enabled                   = var.nwfl_enabled

  retention_policy {
    enabled = var.nwfl_rp_enabled
    days    = var.nwfl_rp_days
  }

  traffic_analytics {
    enabled               = var.nwfl_ta_enabled
    workspace_id          = azurerm_log_analytics_workspace.la.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.la.location
    workspace_resource_id = azurerm_log_analytics_workspace.la.id
    interval_in_minutes   = var.nwfl_ta_interval
  }
}

resource "azurerm_network_watcher_flow_log" "nwfl-2" {
  network_watcher_name = var.nw_name
  resource_group_name  = "NetworkWatcherRG"
  name                 = "${var.nwfl_name}-aks"

  network_security_group_id = var.nwfl_nsg_id_2
  storage_account_id        = var.nwfl_sa_id
  enabled                   = var.nwfl_enabled

  retention_policy {
    enabled = var.nwfl_rp_enabled
    days    = var.nwfl_rp_days
  }

  traffic_analytics {
    enabled               = var.nwfl_ta_enabled
    workspace_id          = azurerm_log_analytics_workspace.la.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.la.location
    workspace_resource_id = azurerm_log_analytics_workspace.la.id
    interval_in_minutes   = var.nwfl_ta_interval
  }
}