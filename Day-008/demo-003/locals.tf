locals {
  tags = {
    "Business Unit"      = "Operations"
    "Cost Centre"        = "CC-IDC-001"
    "Created By"         = "Vishal.Shekhar@domain.com"
    "Managed By"         = "IT Operations"
    "Owner"              = "Bob.Andrew@domain.com"
    "Technical Owner"    = "Vikas.Marathe@domain.com"
    "Environment"        = "Development"
    "Data Type"          = "Internal"
    "System Type"        = "Non-Critical"
    "Project"            = "alpha"
    "Creation Timestamp" = time_static.this.rfc3339
  }
}