resource_group_name          = "example-resources"
location                     = "West Europe"
cluster_name                 = "example-aks1"
dns_prefix                   = "exampleaks1"
default_node_pool_name       = "default"
default_node_pool_node_count = 1
default_node_pool_vm_size    = "Standard_B2s"
identity_type                = "SystemAssigned"
tags = {
  "cluster_name" : "example-aks1"
}
