# lifecycle

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "that" {
  location = data.azurerm_resource_group.this.location
  name     = "rg-beta"

  tags = {
    "Owner" = "Satish"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags, ]
  }
}

data "azurerm_resource_group" "this" {
  name = "rg-alpha"
}

resource "azurerm_virtual_network" "this" {
  address_space       = ["10.0.0.0/24"]
  location            = data.azurerm_resource_group.this.location
  name                = "vnet-alpha"
  resource_group_name = azurerm_resource_group.that.name

  lifecycle {
    create_before_destroy = true
  }
}
