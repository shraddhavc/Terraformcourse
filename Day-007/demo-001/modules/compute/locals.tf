locals {
  tags = {
    "Managed By"         = "Terraform"
    "Creation Timestamp" = time_static.example.id
    "Project"            = var.prefix
  }
}