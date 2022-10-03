# Referencing a List
locals {
  names = ["Yogesh", "Manoj", "Rohan"]

  surnames = {
    "Yogesh" = "Arbal"
    "Manoj"  = "Katkade"
    "Rohan"  = "Shinde"
  }
}

# List values
output "first_name" {
  value = local.names[0]
}

output "second_name" {
  value = local.names[1]
}

output "third_name" {
  value = local.names[2]
}

# Map Values
output "yogesh_surname" {
  value = local.surnames.Yogesh
}

output "manoj_surname" {
  value = local.surnames.Manoj
}

output "rohan_surname" {
  value = local.surnames.Rohan

}