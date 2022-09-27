provider "azurerm" {

    # Using client id and client secret in provider block is not recommended for production code.

    # client_id = ""
    # client_secret = ""
    # subscription_id = ""
    # tenant_id = ""

    features {
    }
}

resource "azurerm_resource_group" "this" {
    name = "rg-alpha"
    location = "westeurope"

    tags = {
      "Owner" = "Team-Alpha"
      "CostCenter" = "100-101"
    }
}