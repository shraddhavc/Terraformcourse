# for_each

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  for_each = {
    "alpha"   = "westeurope"
    "beta"    = "centralus"
    "charlie" = "eastus"
  }

  name     = each.key
  location = each.value
}
