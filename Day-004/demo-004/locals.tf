# Locals
locals {
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