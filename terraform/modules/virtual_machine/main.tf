resource "azurerm_public_ip" "vm_public_ip" {
  name                = var.vm_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.vm_allocation_method
  sku                 = var.vm_sku
}

resource "azurerm_network_interface" "vm_nic" {
  name                = var.vm_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.vm_nic_name}-config"
    subnet_id                     = var.vm_nic_subnet_id
    private_ip_address_allocation = var.vm_nic_private_ip_address_allocation
    private_ip_address            = var.vm_nic_private_ip_address
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }

  depends_on = [
    azurerm_public_ip.vm_public_ip
  ]

}

resource "azurerm_network_interface_security_group_association" "nic-nsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = var.vm_nic_nsg_id

  depends_on = [
    azurerm_network_interface.vm_nic
  ]
}

# revisar
resource "tls_private_key" "private_key" {
  algorithm = var.vm_tls_private_key_algorithm
  rsa_bits  = var.vm_tls_private_key_rsa_bits
}

resource "local_sensitive_file" "ssh-private-key-local" {
  content         = tls_private_key.private_key.private_key_pem
  filename        = "${path.module}/../../private_keys/vm_private_key.pem"
  file_permission = "400"
  depends_on = [
    tls_private_key.private_key
  ]
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = var.vm_size
  admin_username        = var.vm_admin_username

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = tls_private_key.private_key.public_key_openssh
  }

  os_disk {
    caching              = var.vm_os_disk_caching
    storage_account_type = var.vm_os_disk_sorage_account_type
  }

  source_image_reference {
    publisher = var.vm_source_image_reference_publisher
    offer     = var.vm_source_image_reference_offer
    sku       = var.vm_source_image_reference_sku
    version   = var.vm_source_image_reference_version
  }

  depends_on = [
    azurerm_network_interface.vm_nic,
    tls_private_key.private_key
  ]
}