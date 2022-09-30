# Variables
variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}
variable "location" {
  description = "Location of the resource."
  type        = string
}
variable "cluster_name" {
  description = "NAme name of the cluster."
  type        = string
}
variable "dns_prefix" {
  description = "DNS prefix of the cluster. Must be universally unique."
  type        = string
}
variable "default_node_pool_name" {
  description = "Name of the default node pool."
  type        = string
}
variable "default_node_pool_node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}
variable "default_node_pool_vm_size" {
  description = "Size of node in the default node pool"
  type        = string
}
variable "identity_type" {
  description = "Identity type"
  type        = string
}
variable "tags" {
  description = "Tags of the resource."
  type        = map(any)
}