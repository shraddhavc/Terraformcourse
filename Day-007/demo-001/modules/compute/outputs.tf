output "virtual_machine_public_ip" {
  description = "Virtual machine public IP address"
  value       = azurerm_public_ip.example.ip_address
}

output "virtual_machine_username" {
  description = "Virtual machine username"
  value = var.os_profile["admin_username"]

  sensitive = true
}

output "tls_private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}


