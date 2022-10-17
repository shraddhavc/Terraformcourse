provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  count    = 5
  name     = "rg-alpha-${count.index + 1}"
  location = "westeurope"
}

output "ids_with_splat_expression" {
  value = azurerm_resource_group.this[*].id
}

output "ids_with_for_expressions" {
  value = [for azurerm_resource_group in azurerm_resource_group.this : azurerm_resource_group["name"]]
}

output "names_with_splat_expression" {
  value = azurerm_resource_group.this[*].id
}

output "names_with_for_expressions" {
  value = [for azurerm_resource_group in azurerm_resource_group.this : azurerm_resource_group["name"]]
}
