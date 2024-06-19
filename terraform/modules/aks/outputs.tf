output "name" {
  description = "name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "id" {
  description = "The Kubernetes Managed Cluster ID"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_identity_id" {
  description = "The ID of the Service Principal object associated with the created Identity"
  value       = azurerm_kubernetes_cluster.aks.service_principal[0].client_id
}

output "kube_config_raw" {
  description = "Raw Kubernetes config to be used by kubectl and other compatible tools"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "node_resource_group" {
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster. Changing this forces a new resource to be created"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "private_key_openssh" {
  value = azurerm_kubernetes_cluster.aks.linux_profile[0].ssh_key
}