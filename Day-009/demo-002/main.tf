# count

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  count = 10

  location = "westeurope"
  name     = "rg-alpha-${count.index}"
}


