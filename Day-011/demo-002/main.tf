/*
Below Example explains the use of
1. Type constraint
2. Version constraint
3. count
4. for each
5. dynamic block
6. validation
7. length() and index() functions
8. data source
*/

provider "azurerm" {
  features {}
}

terraform {
  required_version = "1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.26.0"
    }
  }
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]*$", var.resource_group_name))
    error_message = "[ERROR]: Ony lower case alphabets, numbers and hyphen(-) is allowed in resource_group_name"
  }
}

variable "subnets" {
  type = list(map(string))
  default = [
    { name = "snet-0", address_prefix = "10.0.0.0/22" },
    { name = "snet-1", address_prefix = "10.0.4.0/22" },
    { name = "snet-2", address_prefix = "10.0.8.0/22" },
    { name = "snet-3", address_prefix = "10.0.12.0/22" }
  ]
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "this" {
  count               = length(var.subnets)
  location            = data.azurerm_resource_group.this.location
  name                = "nsg-count-example-${count.index}"
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_virtual_network" "this" {
  address_space       = ["10.0.0.0/20"]
  location            = data.azurerm_resource_group.this.location
  name                = "vnet-dynamic-block-example"
  resource_group_name = data.azurerm_resource_group.this.name

  dynamic "subnet" {
    for_each = var.subnets
    iterator = subnet
    content {
      address_prefix = subnet.value.address_prefix
      name           = subnet.value.name
      security_group = azurerm_network_security_group.this[index(var.subnets, subnet.value)].id
    }
  }
}


