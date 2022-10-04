# Topics
- [Types of Variables](#types-of-variables)
- [How to use input variable using environment variables?](#how-to-use-input-variable-using-environment-variables?) 
- [local provider](#local-provider)
- [random provider](#random-provider)
- [Interpolation](#interpolation)
- [Sensitive](#sensitive)
- [Referencing lists and maps](#referencing-lists-and-maps)
----------------------------------------------------------------
## Types of variable
https://www.terraform.io/language/expressions/types#types-and-values

- string
- number
- bool
- list/set/tuple
- map/object
- null

### string
``` terraform
variable "name" {
    description = "name of the variable"
    type = string
    default = "satish"
}
```

### number
``` terraform
variable "roll_number" {
    description = "Roll number"
    type = number
    default = 10
}

variable "percentage" {
    description = "Percentage"
    type = number
    default = 76.89
}
```

### Boolean
```terraform
variable "is_eligible" {
    description = "Is eligible for scholarship"
    type = bool
    default = false   # true or false
}
```

### List
```terraform
variable "cidr_blocks" {
    description = "CIDR blocks to be used for network"
    type = list
    default = ["10.0.0.0/16", "172.168.0.0/20"]
}

variable "network_cidr_blocks" {
    description = "CIDR blocks to be used for network"
    type = list(string)
    default = ["10.0.0.0/16", "172.168.0.0/20"]
}

variable "marks" {
    description = "Marks obtained out of 100"
    type = list(number)
    default = [67, 86, 84, 79, 79, 79]
}
```


### set 
No duplicates are allowed.
```terraform
variable "all_marks" {
    description = "Marks obtained out of 100"
    type = set(number)
    default = [67, 86, 84, 79]
}
```

### tuple
```terraform
variable "anything" {
    description = "anything"
    type = tuple
    default = [true, "satish", 200, [10, 20, 30]]
}
```

### map
```terraform
variable "tags" {
    description = "tags"
    type = map
    default = {
        "Name" = "Satish"
        "Location" = "Pune"
    }
}
```


### object
```terraform
variable "rg_config" {
  description = "Resource group config object"
  type = object({
    create_rg = bool
    name      = string
    location  = string
  })
  default = {
    create_rg = true
    name = "rg-alpha"
    location = "eastus"
  }
}
```

### null
```terraform
variable "i_am_null" {
    description = "Null value"
    type = null
    default = null
}
```
----------------------------------------------------------------

## How to use input variable using environment variables?

```terraform
variable "azurerm_resource_group" {}
variable "location"
        
resource "azurerm_resource_group" "example" {
  name = var.azurerm_resource_group
  location = var.location
}
```
If you want to provide the values of variable using the environment variable the use as below for give example.

bash
```bash
export TF_VAR_azurerm_resource_group="rg-alpha"
export TF_VAR_location="eastus"
```
cmd
```cmd
set TF_VAR_azurerm_resource_group="rg-alpha"
set TF_VAR_location="eastus"
```

----------------------------------------------------------------

## Local provider
https://registry.terraform.io/providers/hashicorp/local/latest/docs

----------------------------------------------------------------

## Random provider
https://registry.terraform.io/providers/hashicorp/random/latest/docs

----------------------------------------------------------------

## Interpolation

https://www.terraform.io/language/expressions/strings#interpolation

A ${ ... } sequence is an interpolation, which evaluates the expression given between the markers, converts the result to a string if necessary, and then inserts it into the final string:

```terraform
locals {
  name = "Satish"
  surname = "Ingale"
}

output "fullname" {
  value = "Full name is ${locals.name} ${locals.surname}"
}
```


----------------------------------------------------------------

## Sensitive

Often you need to configure your infrastructure using sensitive or secret information such as usernames, passwords, API tokens, or Personally Identifiable Information (PII). When you do so, you need to ensure that you do not accidentally expose this data in CLI output, log output, or source control.

```terraform
variable "db_password" {
  description = "Password to connect to database"
  type = string
  
  sensitive = true
}
```
or 

```terraform
output "kube_config" {
  value     = azurerm_kubernetes_cluster.example.kube_config_raw
  sensitive = true
}
```
----------------------------------------------------------------
## Referencing lists and maps
https://www.terraform.io/language/expressions/references 