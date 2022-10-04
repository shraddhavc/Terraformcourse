module "vnet" {
  source = "./modules/networks"

  resource_group_name           = var.resource_group_name
  location                      = var.location
  security_group_name           = var.security_group_name
  virtual_network_name          = var.virtual_network_name
  virtual_network_address_space = var.virtual_network_address_space
  dns_servers                   = var.dns_servers
  subnet1_name                  = var.subnet1_name
  subnet2_name                  = var.subnet2_name
  subnet1_address_prefix        = var.subnet1_address_prefix
  subnet2_address_prefix        = var.subnet2_address_prefix
}
