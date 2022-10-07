############## VARIABLES ##################
variable "prefix" {}
variable "location" {}
variable "virtual_network_address_space" {
  type = list(string)
}
variable "subnet_address_prefixes" {
  type = list(string)
}
variable "public_ip_allocation_method" {}
variable "private_ip_address_allocation" {}

variable "storage_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "storage_os_disk" {
  type = object({
    name              = string
    caching           = string
    create_option     = string
    managed_disk_type = string
  })
}

variable "os_profile" {
  type = object({
    admin_username = string
    computer_name  = string
  })
}

variable "os_profile_linux_config" {
  type = object({
    disable_password_authentication = string
  })
}

variable "vm_size" {}
variable "tags" {
  type = map(any)
}

