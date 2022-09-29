provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-charlie"
  location = "East US"

  tags = {
    "Business Unit"   = "Operations"                # ITTeam, DBTeam, OperationsTeam, MigrateTeam, TestingTeam,..etc
    "Cost Centre"     = "CC-IDC-001"                # CC-Id01, CC-Id02,…etc
    "Created By"      = "Vishal.Shekhar@domain.com" # Vishal.Shekhar@domain.com, PaulMickelson@domain.com,…etc.
    "Managed By"      = "IT Operations"             # Name of the team who manages infrastructure
    "Owner"           = "Bob.Andrew@domain.com"     # Business Owner
    "Technical Owner" = "Vikas.Marathe@domain.com"  # Technical Owner
    "Environment"     = "Development"               # Development, Test, Staging, Integration, Preproduction, Production etc
    "Data Type"       = "Internal"                  # Public, Private or Internal, Restricted, Confidential,…etc
    "System Type"     = "Non-Critical"              # Critical, Non-critical, N/A
    "Project"         = "charlie"                   # Project name
  }
}

resource "azurerm_storage_account" "example" {
  name                = "sacharlie161281"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  account_tier             = "Standard"

  allow_nested_items_to_be_public   = true
  default_to_oauth_authentication   = false
  enable_https_traffic_only         = false
  infrastructure_encryption_enabled = false
  large_file_share_enabled          = true
  min_tls_version                   = "TLS1_2"
  nfsv3_enabled                     = false
  public_network_access_enabled     = true
  queue_encryption_key_type         = "Service"
  shared_access_key_enabled         = true

  tags = {
    "Business Unit"   = "Operations"
    "Cost Centre"     = "CC-IDC-001"
    "Created By"      = "Vishal.Shekhar@domain.com"
    "Managed By"      = "IT Operations"
    "Owner"           = "Bob.Andrew@domain.com"
    "Technical Owner" = "Vikas.Marathe@domain.com"
    "Environment"     = "Development"
    "Data Type"       = "Internal"
    "System Type"     = "Non-Critical"
    "Project"         = "charlie"
  }
}