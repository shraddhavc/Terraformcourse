provider "azurerm" {
  features {}
}

terraform {
  required_version = "1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.25.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~>0.8.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0.3"
    }
  }
}