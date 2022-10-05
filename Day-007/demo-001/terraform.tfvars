
prefix   = "alpha"
location = "West Europe"

virtual_network_address_space = ["10.0.0.0/16"]
subnet_address_prefixes       = ["10.0.2.0/24"]
public_ip_allocation_method   = "Static"
private_ip_address_allocation = "Dynamic"

storage_image_reference = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "16.04-LTS"
  version   = "latest"
}
storage_os_disk = {
  name              = "alpha-osdisk1"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "Standard_LRS"
}
os_profile = {
  computer_name  = "example"
  admin_username = "systemadmin"
}
os_profile_linux_config = {
  disable_password_authentication = true
}
vm_size = "Standard_B2s"

tags = { "Owner" = "Satish" }