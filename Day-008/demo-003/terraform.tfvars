prefix                        = "alpha"
location                      = "westeurope"
virtual_network_address_space = ["10.0.0.0/16"]
subnet_address_prefixes       = ["10.0.0.0/24"]

public_ip_allocation_method   = "Static"
private_ip_address_allocation = "Dynamic"

storage_image_reference = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "16.04-LTS"
  version   = "latest"
}

storage_os_disk = {
  name              = "alpha-os-disk"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "Standard_LRS"
}

os_profile = {
  admin_username = "systemadmin"
  computer_name  = "example.com"
}


os_profile_linux_config = {
  disable_password_authentication = true
}

vm_size = "Standard_B2s"

tags = {
  "Business Unit" = "OperationsTeam"
  "Owner"         = "Satish"
}

