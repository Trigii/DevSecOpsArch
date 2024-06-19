resource "azurerm_network_security_group" "nsg" {
  name                = "${var.nsg_name}-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "tfg-vm-inbound" {
  name                        = "${var.nsg_nsr_name}-inbound"
  priority                    = 280
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22", "80", "443"]
  source_address_prefixes     = ["PUBLIC_IP_1", "PUBLIC_IP_2..."]
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "tfg-vm-outbound-1" {
  name                        = "${var.nsg_nsr_name}-deny-all"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "tfg-vm-outbound-2" {
  name                        = "${var.nsg_nsr_name}-allow-vnet"
  priority                    = 290
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "tfg-vm-outbound-3" {
  name                        = "${var.nsg_nsr_name}-allow-internet"
  priority                    = 300
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "8080", "443"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

///////////////////////////////// AKS NSG //////////////////////////////////////

resource "azurerm_network_security_group" "nsg-2" {
  name                = "${var.nsg_name}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "tfg-aks-outbound-1" {
  name                        = "${var.nsg_nsr_name}-deny-all"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg-2.name
}

resource "azurerm_network_security_rule" "tfg-aks-outbound-2" {
  name                        = "${var.nsg_nsr_name}-allow-vnet"
  priority                    = 290
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg-2.name
}

resource "azurerm_network_security_rule" "tfg-aks-outbound-3" {
  name                        = "${var.nsg_nsr_name}-allow-internet"
  priority                    = 300
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "8080", "443"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg-2.name
}

resource "azurerm_network_security_rule" "tfg-aks-outbound-4" {
  name                        = "${var.nsg_nsr_name}-allow-google"
  priority                    = 301
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "8.8.8.8/32"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg-2.name
}