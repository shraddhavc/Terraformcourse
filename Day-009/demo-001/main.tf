# depends_on


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  location = "westeurope"
  name     = "rg-alpha"
}

resource "azurerm_virtual_network" "this" {
  address_space       = ["10.0.0.0/24"]
  location            = "westeurope"
  name                = "vnet-alpha"
  resource_group_name = "rg-alpha"

  depends_on = [azurerm_resource_group.this]
}