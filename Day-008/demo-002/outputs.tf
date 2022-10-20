output "public_ip" {
  description = "Public IP address of the virtual machine"
  value = azurerm_public_ip.this.ip_address
}

output "private_key" {
  description = "Private key date"
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}