# lifecycle

provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "this" {
  location = "westeurope"
  name     = "rg-alpha"
}

resource "azurerm_storage_account" "this" {
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  name                     = "sasomething9876"
  account_replication_type = "LRS"
  account_tier             = "Premium"

  lifecycle {
    create_before_destroy = true
  }
}

