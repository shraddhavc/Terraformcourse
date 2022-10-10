# for_each and count
provider "azurerm" {
  features {}
}

#resource "azurerm_resource_group" "that" {
#  for_each = toset(["dev", "qa", "integ", "preprod", "prod"])
#  name     = "rg-gamma-${each.key}"
#  location = "westeurope"
#}

variable "rg_names" {
  default = ["dev", "qa", "integ", "preprod", "prod"]
}

resource "azurerm_resource_group" "this" {
  count    = length(var.rg_names)
  name     = "rg-gamma-${var.rg_names[count.index]}"
  location = "westeurope"
}





