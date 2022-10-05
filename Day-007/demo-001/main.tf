variable "prefix" {}
variable "location" {}
variable "virtual_network_address_space" {}
variable "subnet_address_prefixes" {}
variable "public_ip_allocation_method" {}
variable "private_ip_address_allocation" {}
variable "vm_size" {}
variable "storage_image_reference" {}
variable "storage_os_disk" {}
variable "os_profile" {}
variable "os_profile_linux_config" {}
variable "tags" {}

module "server" {
  source = "./modules/compute"

  prefix   = var.prefix
  location = var.location

  virtual_network_address_space = var.virtual_network_address_space
  subnet_address_prefixes       = var.subnet_address_prefixes
  public_ip_allocation_method   = var.public_ip_allocation_method
  private_ip_address_allocation = var.private_ip_address_allocation

  vm_size                 = var.vm_size
  storage_image_reference = var.storage_image_reference
  storage_os_disk         = var.storage_os_disk
  os_profile              = var.os_profile
  os_profile_linux_config = var.os_profile_linux_config

  tags = var.tags
}

output "admin_username" {
  value = module.server.virtual_machine_username
  sensitive = true
}

output "public_ip" {
  value = module.server.virtual_machine_public_ip
}

output "private_key" {
  value = module.server.tls_private_key
  sensitive = true
}