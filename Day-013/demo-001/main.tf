provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-resources"
    storage_account_name = "projectalphaterraformbackends"
    container_name       = "tfstates"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "this" {
  location = "westeurope"
  name     = "rg-alpha"
}