variable "resource_group_name" {
  description = "Resources group name"
  type        = string
}

variable "location" {
  description = "Location of the resource"
  type        = string
}

variable "security_group_name" {
  description = "Security group name"
  type        = string

}

variable "virtual_network_name" {
  description = "Virtual network name"
  type        = string
}

variable "virtual_network_address_space" {
  description = "The address space that is used the virtual network. You can supply more than one address space"
  type        = list(any)
}

variable "dns_servers" {
  description = "List of IP addresses of DNS servers"
  type        = list(any)
}

variable "subnet1_name" {
  description = "Subnet-1 name"
  type        = string
}

variable "subnet2_name" {
  description = "Subnet-2 name"
  type        = string
}

variable "subnet1_address_prefix" {
  description = "Subnet-1 address-prefix"
  type        = string
}

variable "subnet2_address_prefix" {
  description = "Subnet-2 address-prefix"
  type        = string
}