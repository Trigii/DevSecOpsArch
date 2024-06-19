resource "azurerm_route_table" "vm_route_table" {
  name                = "${var.rt_name}-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route_table" "aks_route_table" {
  name                = "${var.rt_name}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route" "vm-internet-route" {
  name                   = "${var.route_name}-internet"
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.vm_route_table.name
  address_prefix         = var.vm_route_address_prefix
  next_hop_type          = var.vm_route_next_hop_type
  next_hop_in_ip_address = var.vm_route_next_hop_in_ip_address

  depends_on = [ azurerm_route_table.vm_route_table ]
}

resource "azurerm_route" "aks-default-route" {
  name                   = "${var.route_name}-default"
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.aks_route_table.name
  address_prefix         = var.default_route_address_prefix
  next_hop_type          = var.default_route_next_hop_type
  next_hop_in_ip_address = var.default_route_next_hop_in_ip_address

  depends_on = [ azurerm_route_table.aks_route_table ]
}

resource "azurerm_subnet_route_table_association" "vm-association" {
  subnet_id      = var.vm_subnet_id
  route_table_id = azurerm_route_table.vm_route_table.id
}

resource "azurerm_subnet_route_table_association" "aks-association-1" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.aks_route_table.id
}

resource "azurerm_subnet_route_table_association" "aks-association-2" {
  subnet_id      = var.aks_subnet_id_2
  route_table_id = azurerm_route_table.aks_route_table.id
}