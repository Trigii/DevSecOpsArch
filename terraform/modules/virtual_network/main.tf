############################# VIRTUAL NETWORK #############################
resource "azurerm_virtual_network" "vnet-preprod-showcase" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

############################# SUBNETS #############################
resource "azurerm_subnet" "firewall_subnet" {
  name                 = var.firewall_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-preprod-showcase.name
  address_prefixes     = var.firewall_address_prefix
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-preprod-showcase.name
  address_prefixes     = var.bastion_address_prefix
}

resource "azurerm_subnet" "aks_subnet_1" {
  name                 = var.aks_subnet_name_1
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-preprod-showcase.name
  address_prefixes     = var.aks_address_prefix_1
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}

resource "azurerm_subnet" "aks_subnet_2" {
  name                 = var.aks_subnet_name_2
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-preprod-showcase.name
  address_prefixes     = var.aks_address_prefix_2
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}