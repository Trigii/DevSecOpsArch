resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
}

resource "azurerm_firewall_policy" "fw_policy" {
  name                = "${var.fw_name}-policy"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_firewall_policy_rule_collection_group" "example" {
  name               = "${var.fw_name}-rule-collection-group"
  firewall_policy_id = azurerm_firewall_policy.fw_policy.id
  priority           = 500

  network_rule_collection {
    name     = "${var.fw_name}-nw-vm-rule-collection"
    priority = 400
    action   = "Allow"

    rule {
      name                  = "allow-all"
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
  nat_rule_collection {
    name     = "${var.fw_name}-nat-vm-rule-collection"
    priority = 300
    action   = "Dnat"

    rule {
      name                = "${var.fw_name}-vm-ssh"
      protocols           = ["TCP", "UDP"]
      source_addresses    = ["PUBLIC_IP_1", "PUBLIC_IP_2..."]
      destination_address = azurerm_public_ip.public_ip.ip_address
      destination_ports   = ["22"]
      translated_address  = "142.10.32.4"
      translated_port     = "22"
    }
    rule {
      name                = "${var.fw_name}-allow-https"
      protocols           = ["TCP", "UDP"]
      source_addresses    = ["PUBLIC_IP_1", "PUBLIC_IP_2..."]
      destination_address = azurerm_public_ip.public_ip.ip_address
      destination_ports   = ["443"]
      translated_address  = "142.10.0.156"
      translated_port     = "443"
    }
    rule {
      name                = "${var.fw_name}-allow-http"
      protocols           = ["TCP", "UDP"]
      source_addresses    = ["PUBLIC_IP_1", "PUBLIC_IP_2..."]
      destination_address = azurerm_public_ip.public_ip.ip_address
      destination_ports   = ["80"]
      translated_address  = "142.10.0.156"
      translated_port     = "80"
    }
    rule {
      name                = "${var.fw_name}-allow-ssh"
      protocols           = ["TCP", "UDP"]
      source_addresses    = ["PUBLIC_IP_1", "PUBLIC_IP_2..."]
      destination_address = azurerm_public_ip.public_ip.ip_address
      destination_ports   = ["22"]
      translated_address  = "142.10.0.156"
      translated_port     = "22"
    }
  }
}

resource "azurerm_firewall" "firewall" {
  name                = var.fw_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  firewall_policy_id  = azurerm_firewall_policy.fw_policy.id

  ip_configuration {
    name                 = var.ip_config_name
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  depends_on = [
    azurerm_public_ip.public_ip, azurerm_firewall_policy.fw_policy
  ]
}