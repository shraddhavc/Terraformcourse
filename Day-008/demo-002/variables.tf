############## VARIABLES ##################
variable "prefix" {
  description = "The prefix to use for the infrastructure"
  type = string
  default = "alpha"
}
variable "location" {
  description = "The location of the resource."
  type = string
  default = "westeurope"
}
variable "virtual_network_address_space" {
  description = "Virtual network address space."
  type = list(string)
}
variable "subnet_address_prefixes" {
  description = "Subnet address prefixes."
  type = list(string)
}
variable "public_ip_allocation_method" {
  description = "Public IP allocation method, Either Static or Dynamic"
  type = string
}
variable "private_ip_address_allocation" {
  description = "Private IP allocation method, Either Static or Dynamic"
  Type = string
}

variable "storage_image_reference" {
  description = "Storage image reference configuration block."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "storage_os_disk" {
  description = "Storage OS disk configuration block"
  type = object({
    name              = string
    caching           = string
    create_option     = string
    managed_disk_type = string
  })
}

variable "os_profile" {
  Description = "Operating System profile configuration block"
  type = object({
    admin_username = string
    computer_name  = string
  })
}

variable "os_profile_linux_config" {
  Description = "Linus operating system configuration block"
  type = object({
    disable_password_authentication = string
  })
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type = string
}
variable "tags" {
  description = "Tags of the resource."
  type = map(any)
}

