output "log_analytics_id" {
  description = "The Log Analytics ID"
  value       = azurerm_log_analytics_workspace.la.id
}

output "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID"
  value       = azurerm_log_analytics_workspace.la.workspace_id
}