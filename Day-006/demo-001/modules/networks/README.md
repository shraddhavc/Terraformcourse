# virtual network module
Usage
```terraform
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
```
outputs
- `module.vnet.resource_group_id`
- `module.vnet.virtual_network_id`


Example

```terraform
module "vnet" {
  source = "./modules/networks"

  resource_group_name           = "RG-Prod"
  location                      = "westeurope"
  security_group_name           = "prod-nsg"
  virtual_network_name          = "vnet-prod"
  virtual_network_address_space = ["10.0.0.0/16"]
  dns_servers                   = ["8.8.8.8", "4.4.4.4"]
  subnet1_name                  = "sub-prod"
  subnet2_name                  = "sub-preprod"
  subnet1_address_prefix        = "10.0.1.0/24"
  subnet2_address_prefix        = "10.0.2.0/24"

}
```
