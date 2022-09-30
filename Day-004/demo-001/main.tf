// Recap of variables
provider "azurerm" {
  features {}
}

variable "location" {
  default = "eastus"
}
variable "resource_group_name" {
  default = "rg-alpha"
}
variable "tags" {
  default = { "Created By" = "Terraform" }
}

locals {
  tags = {
    "Owned By"      = "Satish"
    "Business Unit" = "IT"
  }
}

resource "azurerm_resource_group" "example" {
  location = var.location
  name     = lower(var.resource_group_name) # lower is the name of function which we will cover later
  tags     = merge(var.tags, local.tags)    # marge is the name of function which we will cover later
}


