# Dynamic block example with count and for_each
provider "azurerm" {
  features {}
}
variable "subnets" {
  description = "list of values to assign to subnets"
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [
    { name = "snet0", address_prefix = "10.10.1.0/24" },
    { name = "snet1", address_prefix = "10.10.2.0/24" },
    { name = "snet2", address_prefix = "10.10.3.0/24" },
    { name = "snet3", address_prefix = "10.10.4.0/24" }
  ]
}

variable "resource_group_name" {
  description = "The name of the resource group"
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "this" {
  count               = length(var.subnets)
  location            = data.azurerm_resource_group.this.location
  name                = "vnet-count-example-${count.index}"
  resource_group_name = data.azurerm_resource_group.this.name
}
resource "azurerm_virtual_network" "this" {
  name                = "vnet-dynamicblock-example"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  address_space       = ["10.10.0.0/16"]

  dynamic "subnet" {
    for_each = var.subnets
    iterator = item
    content {
      name           = item.value.name
      address_prefix = item.value.address_prefix
      security_group = azurerm_network_security_group.this[index(var.subnets, item.value)].id
    }
  }
}