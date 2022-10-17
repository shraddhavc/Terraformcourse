provider "azurerm" {
  features {}
}

variable "tags" {
  type = map(any)
}
#----------------------------------------------------------------
## var = condition ? value1 : value2
/*
1. if environment is production then resource group name should be 'rg-alpha-production' else 'rg-alpha-non-production'
2. if environment is production then resource group location should be 'eastus' else 'centralindia'
3. if environment is production only then create storage account
*/
#----------------------------------------------------------------
resource "azurerm_resource_group" "this" {
  name     = var.tags["environment"] == "production" ? "rg-alpha-production" : "rg-alpha-non-production"
  location = var.tags["environment"] == "production" ? "eastus" : "centralindia"

  tags = var.tags
}

resource "azurerm_storage_account" "this" {
  count                    = var.tags["environment"] == "production" ? 1 : 0
  name                     = "abcdefcg"
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  account_replication_type = "LRS"
  account_tier             = "Standard"
}
