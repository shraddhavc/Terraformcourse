module "vnet" {
  source        = "git::https://gitlab.com/satishing/azurerm-vnet.git?ref=v0.0.3"
  prefix        = "final-lab"
  location      = "westeurope"
  address_space = ["10.0.0.0/24"]
  subnets = [
    { name = "snet-0", address_prefix = "10.0.0.0/22" },
    { name = "snet-1", address_prefix = "10.0.4.0/22" },
    { name = "snet-2", address_prefix = "10.0.8.0/22" },
    { name = "snet-3", address_prefix = "10.0.12.0/22" }
  ]

  tags = {
    Owner = "Satish"
  }
}

output "resource_group_name" {
  value = module.vnet.resource_group_name
}

output "resource_group_id" {
  value = module.vnet.resource_group_id
}

output "virtual_network_id" {
  value = module.vnet.virtual_network_id
}