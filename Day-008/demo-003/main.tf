################## RESOURCES ########################
resource "time_static" "this" {}

resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-resources"
  location = var.location
  tags     = merge(var.tags, local.tags)
}


resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}-network"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.virtual_network_address_space
  tags                = merge(var.tags, local.tags)
}


resource "azurerm_subnet" "this" {
  name                 = "${var.prefix}-subnet"
  virtual_network_name = azurerm_virtual_network.this.name
  resource_group_name  = azurerm_resource_group.this.name
  address_prefixes     = var.subnet_address_prefixes
}


resource "azurerm_public_ip" "this" {
  name                = "${var.prefix}-public-ip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = var.public_ip_allocation_method
  tags                = merge(var.tags, local.tags)
}


resource "azurerm_network_interface" "this" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "${var.prefix}-ipconfig"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "rule-${var.prefix}-http"
    priority                   = 100
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "80"
    destination_address_prefix = "*"
  }
  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "rule-${var.prefix}-ssh"
    priority                   = 110
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "22"
    destination_address_prefix = "*"
  }

  tags = merge(var.tags, local.tags)
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}



resource "azurerm_virtual_machine" "this" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
  network_interface_ids = [azurerm_network_interface.this.id]
  vm_size               = var.vm_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.storage_image_reference["publisher"]
    offer     = var.storage_image_reference["offer"]
    sku       = var.storage_image_reference["sku"]
    version   = var.storage_image_reference["version"]
  }

  storage_os_disk {
    create_option     = var.storage_os_disk["create_option"]
    name              = var.storage_os_disk["name"]
    caching           = var.storage_os_disk["caching"]
    managed_disk_type = var.storage_os_disk["managed_disk_type"]
  }

  os_profile {
    admin_username = var.os_profile["admin_username"]
    computer_name  = var.os_profile["computer_name"]
  }

  os_profile_linux_config {
    disable_password_authentication = var.os_profile_linux_config["disable_password_authentication"]
    ssh_keys {
      key_data = tls_private_key.this.public_key_openssh
      path     = "/home/${var.os_profile["admin_username"]}/.ssh/authorized_keys"
    }
  }

  provisioner "file" {
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.this.ip_address
      user        = var.os_profile["admin_username"]
      private_key = tls_private_key.this.private_key_pem
    }

    source      = "${path.cwd}/scripts/install.sh"
    destination = "/home/${var.os_profile["admin_username"]}/install.sh"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.this.ip_address
      user        = var.os_profile["admin_username"]
      private_key = tls_private_key.this.private_key_pem
    }

    inline = [
      "ls -lrt /home/${var.os_profile["admin_username"]}",
      "chmod +x /home/${var.os_profile["admin_username"]}/install.sh",
      "sudo /home/${var.os_profile["admin_username"]}/install.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo http://${azurerm_public_ip.this.ip_address}/index.html > ${path.cwd}/application_url.txt"
  }

  tags = merge(var.tags, local.tags)

  depends_on = [azurerm_public_ip.this]
}