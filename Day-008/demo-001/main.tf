provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {
}

output "id" {
  value = data.azurerm_subscription.id
}

output "subscription_id" {
  value = data.azurerm_subscription.subscription_id
}

output "display_name" {
  value = data.azurerm_subscription.display_name
}

output "tenant_id" {
  value = data.azurerm_subscription.tenant_id
}