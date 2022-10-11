# Topics

- [Operators](#operators)
- [Functions](#functions)
- [Expressions](#expressions)
- [Type Constraints](#type-constraints)
- [Version Constraints](#version-constraints)
- [Validations](#validations)
- [Dynamic Block](#dynamic-block)

--------------------------------------------------------------------------------

## Operators
| Operator Type | Operators                 |   
|---------------|---------------------------|
| Arithematic   | `+`, `-`, `*`, `/`, `%`   |
| Equality      | `==`, `!=`                |
| Comparison    | `<`, `<=`, `>`, `>=`      |
| Logical       | `&&`, `!`, `&#124;&#124;` |                

--------------------------------------------------------------------------------

## Functions
The Terraform language supports only the functions built in to the language are available for use.
You can experiment with the behavior of Terraform's built-in functions from the Terraform expression console, by running the `terraform console` command:

| Numeric  | String     | Collection      | Encoding         | Filesystem   | Date & Time | Hash & Crypto    | IP Network  | Type Conversion |
|----------|------------|-----------------|------------------|--------------|-------------|------------------|-------------|-----------------|
| abs      | chomp      | alltrue         | base64decode     | abspath      | formatdate  | base64sha256     | cidrhost    | can             |
| ceil     | endswith   | anytrue         | base64encode     | dirname      | timeadd     | base64sha512     | cidrnetmask | nonsensitive    |
| floor    | format     | chunklist       | base64zip        | pathexpand   | timecmp     | bcrypt           | cidrsubnet  | sensitive       |
| log      | formatlist | coalesce        | csvdecode        | basename     | timestamp   | filebase64sha256 | cidrsubnets | tobool          |
| max      | indent     | coalescelist    | jsondecode       | file         |             | filebase64sha512 |             | tolist          |
| min      | join       | compact         | jsobencode       | filexists    |             | filemd5          |             | tomap           |
| parseint | lower      | contains        | textdecodebase64 | fileset      |             | filesha1         |             | tonumber        |
| pow      | regex      | element         | textencodebase64 | filebase64   |             | filesha256       |             | toset           |
| signum   | regexall   | flatten         | urlencode        | templatefile |             | filesha512       |             | tostring        |
|          | replace    | index           | yamldecode       |              |             | md5              |             | try             |
|          | split      | keys            | yamlencode       |              |             | rsadecrypt       |             | type            |
|          | startswith | length          |                  |              |             | sha1             |             |                 |
|          | strrev     | list            |                  |              |             | sha256           |             |                 |
|          | substr     | lookup          |                  |              |             | sha512           |             |                 |
|          | title      | map             |                  |              |             | uuid             |             |                 |
|          | trim       | matchkeys       |                  |              |             | uuidv5           |             |                 |
|          | trimprefix | merge           |                  |              |             |                  |             |                 |
|          | trimsuffix | one             |                  |              |             |                  |             |                 |
|          | trimspace  | range           |                  |              |             |                  |             |                 |
|          | upper      | reverse         |                  |              |             |                  |             |                 |
|          |            | setintersection |                  |              |             |                  |             |                 |
|          |            | setproduct      |                  |              |             |                  |             |                 |
|          |            | setsubtract     |                  |              |             |                  |             |                 |
|          |            | setunion        |                  |              |             |                  |             |                 |
|          |            | slice           |                  |              |             |                  |             |                 |
|          |            | sort            |                  |              |             |                  |             |                 |
|          |            | sum             |                  |              |             |                  |             |                 |
|          |            | transpose       |                  |              |             |                  |             |                 |
|          |            | values          |                  |              |             |                  |             |                 |
|          |            | zipmap          |                  |              |             |                  |             |                 |

--------------------------------------------------------------------------------

## Expressions
- ### Conditional Expressions
  The syntax of a conditional expression is as follows:

  ```terraform
   condition ? true_val : false_val
  ```
  Example
  ```terraform
   public_ip_allocation_method = var.environment == "prod" ? "Static" : "Dynamic"
  ```
  
- ### `for` Expressions
  The syntax of a conditional expression is as follows:

  ```
   [for i in var.list : i]
  ```
  
  - A for expression's input (given after the in keyword) can be a `list`, a `set`, a `tuple`, a `map`, or an `object`.
  
    Examples
    ```terraform
     [for k, v in var.map : length(k) + length(v)]
    ```
    ```terraform
     [for i, v in var.list : "${i} is ${v}"]
     # where i or idx refers to index
    ```
  
  - The type of brackets around the for expression decide what type of result it produces.
  
    Example
    ```terraform
     {for s in var.list : s => upper(s)}
     # where i or idx refers to index
    ```
  - A `for` expression can also include an optional if clause to filter elements
    Example
    ```terraform
     [for s in var.list : upper(s) if s != ""]
    ```

- ### Splat Expressions
  A `splat expression` provides a more concise way to express a common operation that could otherwise be performed with a for expression.

  Examples

  `[for o in var.list : o.id]` is equivalent to `var.list[*].id`.

  `[for o in var.list : o.interfaces[0].name]` is equivalent to `var.list[*].interfaces[0].name`.

--------------------------------------------------------------------------------

## Type Constraints
Type constraints are used to validate user-provided values for their input variables and resource arguments.
- ### Primitive Types
  `string`, `number` and `bool`
- ### Complex Types
  `list` and `map`
- ### Structural Types
  `object` and `tuple`
- ### Dynamic Types
  `any`

--------------------------------------------------------------------------------

## Version Constraints
Terraform lets you specify a range of acceptable versions for **Modules**, **Provider requirements** and `required_version` setting in to **terraform block**.
Example
```terraform
version = ">= 1.2.0, < 2.0.0"
```
The following operators are valid:

`=`: (or no operator): Allows only one exact version number. Cannot be combined with other conditions.

`!=`: Excludes an exact version number.

`>, >=, <, <=`: Comparisons against a specified version, allowing versions for which the comparison is true. "Greater-than" requests newer versions, and "less-than" requests older versions.

`~>`: Allows only the rightmost version component to increment. For example, to allow new patch releases within a specific minor release, use the full version number ~> 1.0.4 will allow installation of 1.0.5 and 1.0.10 but not 1.1.0. This is usually called the pessimistic constraint operator.

--------------------------------------------------------------------------------

## Validations

Terraform allows to add validations or custom checks helping consumers more easily diagnose issues in their configurations. 

Validations or custom condition checks can be applied on 
- ### Input variables
  ```terraform
    variable "vpc_cidr" {
      description = "Kubernetes cluster CIDR notation for vpc."
      type = string
      validation {
        condition     = (
                          try(cidrhost(var.vpc_cidr, 0), null) == "172.28.0.0" &&
                          try(cidrnetmask(var.vpc_cidr), null) == "255.255.0.0"
                        )
        error_message = "Vpc_cidr value must be greater than 172.0.0.0/16."
      }
    }
  
    variable "enable_monitoring" {
      description   = "Enable monitoring for the cluster."
      type          = bool
      validation {
        condition = can(regex("^([t][r][u][e]|[f][a][l][s][e])$",var.enable_monitoring))
        error     = "The boolean_variable must be either true or false."
      }
    }
  ```
- ### Preconditions and Postconditions
  ```terraform
  data "aws_ami" "example" {
    owners = ["amazon"]
  
    filter {
      name   = "image-id"
      values = ["ami-abc123"]
    }
  }
  
  resource "aws_instance" "example" {
    instance_type = "t3.micro"
    ami           = data.aws_ami.example.id
  
    lifecycle {
      # The AMI ID must refer to an AMI that contains an operating system
      # for the `x86_64` architecture.
      precondition {
        condition     = data.aws_ami.example.architecture == "x86_64"
        error_message = "The selected AMI must be for the x86_64 architecture."
      }
  
      # The EC2 instance must be allocated a public DNS hostname.
      postcondition {
        condition     = self.public_dns != ""
        error_message = "EC2 instance must be in a VPC that has public DNS hostnames enabled."
      }
    }
  }    
  ```
- ### Few more examples of Conditional Expressions
  ```terraform
    condition = var.name != "" && lower(var.name) == var.name
    #----------------------------------------------------------------
    condition = contains(["STAGE", "PROD"], var.environment)
    #----------------------------------------------------------------
    condition = length(var.items) != 0
    #----------------------------------------------------------------
    condition = alltrue([
      for v in var.instances : contains(["t2.micro", "m3.medium"], v.type)
    ])
    #----------------------------------------------------------------
    condition = can(regex("^[a-z]+$", var.name))
    #----------------------------------------------------------------
    resource "aws_instance" "example" {
      instance_type = "t2.micro"
      ami           = "ami-abc123"

      lifecycle {
        postcondition {
          condition     = self.instance_state == "running"
          error_message = "EC2 instance must be running."
       }
      }
    }
  ```
--------------------------------------------------------------------------------

## Dynamic Block
Terraform supports dynamic block inside `resource`, `data`, `provider`, and `provisioner`
```terraform
locals {
  subnets = [{
      name           = "snet01"
      address_prefix = "192.168.1.0/24"
    },
    {
      name           = "snet02"
      address_prefix = "192.168.2.0/24"
    }]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-alpha"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["192.168.0.0/16"]

  dynamic "subnet" {
    for_each = local.subnets
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.address_prefix
    }
  }
}
```