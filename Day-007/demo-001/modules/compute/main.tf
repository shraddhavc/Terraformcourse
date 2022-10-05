resource "time_static" "example" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-${var.prefix}-resources"
  location = var.location

  tags = merge(var.tags, local.tags)
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-${var.prefix}-network"
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  tags = merge(var.tags, local.tags)
}

resource "azurerm_subnet" "example" {
  name                 = "snet-${var.prefix}-internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_network_security_group" "example" {
  name                = "nsg-${var.prefix}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "rule-${var.prefix}-1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule-${var.prefix}-2"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = merge(var.tags, local.tags)
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_public_ip" "example" {
  name                = "pip-${var.prefix}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = var.public_ip_allocation_method

  tags = merge(var.tags, local.tags)
}

resource "azurerm_network_interface" "example" {
  name                = "nic-${var.prefix}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "nic-ipcfg-${var.prefix}"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.example.id
  }

  tags = merge(var.tags, local.tags)
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_virtual_machine" "example" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = var.vm_size

  # set to false to prevent deletion of the OS disk automatically
  delete_os_disk_on_termination = true

  # set to false to prevent deletion of the data disks automatically
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.storage_image_reference["publisher"]
    offer     = var.storage_image_reference["offer"]
    sku       = var.storage_image_reference["sku"]
    version   = var.storage_image_reference["version"]
  }
  storage_os_disk {
    name              = var.storage_os_disk["name"]
    caching           = var.storage_os_disk["caching"]
    create_option     = var.storage_os_disk["create_option"]
    managed_disk_type = var.storage_os_disk["managed_disk_type"]
  }
  os_profile {
    computer_name  = var.os_profile["computer_name"]
    admin_username = var.os_profile["admin_username"]
  }

  os_profile_linux_config {
    disable_password_authentication = var.os_profile_linux_config["disable_password_authentication"]
    ssh_keys {
      key_data = tls_private_key.example.public_key_openssh
      path     = "/home/${var.os_profile["admin_username"]}/.ssh/authorized_keys"
    }
  }

  # file provisioner
  provisioner "file" {
    connection {
      type = "ssh"
      host = azurerm_public_ip.example.ip_address
      user = var.os_profile["admin_username"]
      private_key = tls_private_key.example.private_key_pem
    }
    source = "${path.module}/scripts/install.sh"
    destination = "/home/${var.os_profile["admin_username"]}/install.sh"
  }

  # local-exec provisioner
  provisioner "local-exec" {
    command = "echo http://${azurerm_public_ip.example.ip_address}/index.html > application_url.txt"
  }

  # remote-exec provisioner
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = azurerm_public_ip.example.ip_address
      user = var.os_profile["admin_username"]
      private_key = tls_private_key.example.private_key_pem
    }

    inline = [
      "ls -lrt /home/${var.os_profile["admin_username"]}",
      "sudo chmod +x /home/${var.os_profile["admin_username"]}/install.sh",
      "sudo /home/${var.os_profile["admin_username"]}/install.sh",
    ]
  }

  tags = merge(var.tags, local.tags)

  depends_on = [
    azurerm_network_interface.example,
    azurerm_public_ip.example
  ]
}