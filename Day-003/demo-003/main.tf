provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  default = "rg-alpha"
}

variable "location" {
  default = "westeurope"
}

resource "azurerm_resource_group" "example" {
  name = var.resource_group_name
  location = var.location
}


/*
You can override the defaults by providing values for the variables during the plan and apply.

$ terraform plan --var resource_group_name=rg-charlie --var location=eastus

$ terraform apply --var resource_group_name=rg-charlie --var location=eastus
*/
