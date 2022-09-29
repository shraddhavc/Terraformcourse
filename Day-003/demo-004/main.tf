provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}
variable "location" {
  description = "Location of the resource."
  type        = string
}

variable "tags" {
  description = "Tags of the resource."
  type        = map(any)
  default = {
    "Managed By" = "Terraform"
  }
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}


# Application Team - Pls provide a resource group for the application deployment for Dev Environment
# terraform plan --var-file dev.tfvars

# Testing Team     - Pls provide a resource group for the application deployment for QA Environment
# terraform plan --var-file qa.tfvars

# Integration Team - Pls provide a resource group for the application deployment for Integ Environment
# terraform plan --var-file integ.tfvars

# PreProd          - Pls provide a resource group for the application deployment for ProProd Environment
# terraform plan --var-file preprod.tfvars

# Prod             - Pls provide a resource group for the application deployment for Prod Environment
# terraform plan --var-file prod.tfvars