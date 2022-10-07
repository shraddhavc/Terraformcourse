# Provider
provider "azurerm" {
  features {}
}

# Variables
variable "location" {
  description = "Location of the resource."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Resources
resource "azurerm_resource_group" "example" {
  location = var.location
  name     = var.resource_group_name
}

# Outputs
output "resource_group_id" {
  value = azurerm_resource_group.example.id
}