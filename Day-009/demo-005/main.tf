# provider
provider "azurerm" {
  alias           = "foo"
  environment     = "public"
  client_id       = "abc"
  client_secret   = "abc-secret"
  tenant_id       = "this"
  subscription_id = "this"
  features {}
}


provider "azurerm" {
  alias           = "bar"
  environment     = "usgovernment"
  client_id       = "xyz"
  client_secret   = "xyz-secret"
  tenant_id       = "that"
  subscription_id = "that"
  features {}
}


resource "azurerm_resource_group" "this" {
  provider = "azurerm.bar"

  location = "eastus"
  name     = "rg-alpha"
}


resource "azurerm_resource_group" "that" {
  provider = "azurerm.foo"

  location = "eastus"
  name     = "rg-beta"
}