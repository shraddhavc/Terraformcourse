module "vnet" {
  source = "./modules/networks"

  resource_group_name           = "rg-charlie-app1"
  location                      = "westeurope"
  security_group_name           = "nsg-charlie"
  virtual_network_name          = "vnet-charlie"
  virtual_network_address_space = ["10.0.0.0/16"]
  dns_servers                   = ["8.8.8.8", "4.4.4.4"]
  subnet1_name                  = "snet-private"
  subnet2_name                  = "snet-public"
  subnet1_address_prefix        = "10.0.1.0/24"
  subnet2_address_prefix        = "10.0.2.0/24"
}