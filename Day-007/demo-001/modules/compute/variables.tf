variable "prefix" {
  description = "Prefix for the resources to be created."
  type        = string
  default     = "lensjuk"
}

variable "location" {
  description = "Location of the resources."
  type        = string
}

variable "virtual_network_address_space" {
  description = "Virtual network address space to be used."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Subnet address prefix to be used."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "public_ip_allocation_method" {
  description = "Public IP allocation method to be used. (Static or Dynamic)"
  type        = string
  default     = "Dynamic"
}
variable "private_ip_address_allocation" {
  description = "Private IP allocation method to be used. (Static or Dynamic)"
  type        = string
  default     = "Dynamic"
}
variable "vm_size" {
  description = "Size of the virtual machine."
  type        = string
  default     = "Standard_B2s"
}
variable "storage_image_reference" {
  description = "Storage image reference configuration block."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
variable "storage_os_disk" {
  description = "Storage OS disk configuration block."
  type = object({
    name              = string
    caching           = string
    create_option     = string
    managed_disk_type = string
  })
  default = {
    name              = "osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}
variable "os_profile" {
  description = "Operating System profile configuration block."
  type = object({
    computer_name  = string
    admin_username = string
  })
  default = {
    computer_name  = "example.com"
    admin_username = "systemadmin"
  }
}
variable "os_profile_linux_config" {
  description = "Linux operating system configuration block."
  type = object({
    disable_password_authentication = bool
  })
  default = {
    disable_password_authentication = false
  }
}
variable "tags" {
  description = "Tags of the resource."
  type        = map(any)
  default     = null
}