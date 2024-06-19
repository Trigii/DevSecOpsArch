# Registers the generated values during the playbook execution which will be necessary in the future. The output values render after a terraform apply
/*
########################### RESOURCE GROUPS ###########################
output "rg_1_name" {
  value = azurerm_resource_group.Main-tfg-devsecops-pro.name
}

output "rg_1_location" {
  value = azurerm_resource_group.Main-tfg-devsecops-pro.location
}

output "rg_2_name" {
  value = azurerm_resource_group.Aks-tfg-devsecops-pro.name
}

output "rg_2_location" {
  value = azurerm_resource_group.Aks-tfg-devsecops-pro.location
}
########################################################################
*/

output "resource_group_name" {
  value = var.rg_principal_name
}

output "aks_name" {
  value = var.aks_name
}

output "firewall_public_ip" {
  value = module.azurerm_firewall.firewall_public_ip
}
