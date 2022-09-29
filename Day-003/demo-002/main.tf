# Input variable example
# User must provide a value for input variables
# Only for development purpose. Not recommended for production

provider "azurerm" {
  features {}
}

variable "resource_group_name" {}
variable "location" {}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    "Managed By" = "Terraform"
  }
}

