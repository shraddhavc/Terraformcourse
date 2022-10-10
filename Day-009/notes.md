## Meta Arguments

- depends_on
- count
- for_each
- provider
- lifecycle

----------------------------------------------------------------
### `depends_on`
Use the `depends_on` meta-argument to handle hidden resource or module dependencies that Terraform cannot automatically infer. You only need to explicitly specify a dependency when a resource or module relies on another resource's behavior but does not access any of that resource's data in its arguments.


Example
```terraform
resource "azurerm_virtual_machine" "this" {
  
  network_interface_ids = [azurerm_network_interface.this.id]

  depends_on = [
    azurerm_network_interface_application_security_group_association.this
  ]
}
```

----------------------------------------------------------------
### `count`
If a resource or module block includes a count argument whose value is a whole number, Terraform will create that many instances.

In blocks where `count` is set, an additional count object is available in expressions, so you can modify the configuration of each instance. This object has one attribute:
`count.index` — The distinct index number (starting with 0) corresponding to this instance.
_
**Note**: A given resource or module block cannot use both `count` and `for_each`._

Example
```terraform
resource "azurerm_resource_group" "this" {
  count = 10

  location = "westeurope"
  name     = "rg-alpha-${count.index}"
}
```
----------------------------------------------------------------
### `for_each`
If a resource or module block includes a `for_each` argument whose value is a map or a set of strings, Terraform creates one instance for each member of that map or set.

_**Note**: A given resource or module block cannot use both `count` and `for_each`._

Example
```terraform
variable "subnet" {
  description = "Map of Azure VNET subnet configuration"
  type        = map(any)
  default = {
    app_subnet = {
      name                 = "app_subnet"
      resource_group_name  = "vCloud-lab.com"
      virtual_network_name = "example_vnet"
      address_prefixes     = ["10.0.1.0/24"]
    },
    db_subnet = {
      name                 = "db_subnet"
      resource_group_name  = "vCloud-lab.com"
      virtual_network_name = "example_vnet"
      address_prefixes     = ["10.0.2.0/24"]
    }
  }
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnet

  name                 = each.value["name"]
  resource_group_name  = each.value["resource_group_name"]
  virtual_network_name = each.value["virtual_network_name"]
  address_prefixes     = each.value["address_prefixes"]
  depends_on           = [azurerm_virtual_network.vnet]
}
```

----------------------------------------------------------------
### `provider`

The `provider` meta-argument specifies which provider configuration to use for a resource, overriding Terraform's default behavior of selecting one based on the resource type name.

Example
```terraform
# default configuration
provider "google" {
  region = "us-central1"
}

# alternate configuration, whose alias is "europe"
provider "google" {
  alias  = "europe"
  region = "europe-west1"
}

resource "google_compute_instance" "example" {
  # This "provider" meta-argument selects the google provider
  # configuration whose alias is "europe", rather than the
  # default configuration.
  provider = google.europe

  # ...
}
```

----------------------------------------------------------------
### `lifecycle`
Lifecycle arguments help control the flow of your Terraform operations by creating custom rules for resource creation and destruction.

The arguments available within a `lifecycle` block are `create_before_destroy`, `prevent_destroy`, `ignore_changes`, and `replace_triggered_by`.

Example

```terraform
resource "azurerm_resource_group" "example" {
  # ...

  lifecycle {
    create_before_destroy = true
  }
}
```

```terraform
resource "azurerm_resource_group" "example" {
  # ...

  lifecycle {
    prevent_destroy = true
  }
}
```

```terraform
resource "azurerm_resource_group" "example" {
  # ...

  lifecycle {
    ignore_changes = [tags,]
  }
}
```

```terraform
resource "random_id" "example" {
  byte_length = 2
}

resource "azurerm_resource_group" "example" {
  name = "rg-example-${random_id.example.id}"
  # ...

  lifecycle {
    replace_triggered_by = [random_id.example.id]
  }
}
```

----------------------------------------------------------------
**Terraform Documentation** : [https://www.terraform.io/language/meta-arguments/lifecycle](https://www.terraform.io/language/meta-arguments/lifecycle)