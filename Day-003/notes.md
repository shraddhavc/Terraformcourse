# Different methods to provide values for variable in terraform

- [Interactive mode](#interactive-mode)
- [Using variable defaults](#)
- [Using terraform commandline argument `--var`](#using-terraform-commandline-argument-`--var`) 
- [Using terraform commandline argument `--var-file`](#using-terraform-commandline-argument-`--var-file`)
- [Using environment variable `TF_VAR_<variable_name>`](#using-environment-variable-`TF_VAR_<variable_name>`)


### Interactive mode
```terraform
variable "resource_group_name" {}
variable "location" {}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}
```
If you do not provide value to variables in any way, terraform will ask you to input variable value.
```bash
$ terraform plan
var.location
  Enter a value: 

```

### Using variable defaults
```terraform
variable "resource_group_name" {
  default = "rg-alpha"
}
variable "location" {
  default = "westeurope"
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}
```

### Using terraform commandline argument `--var`
You can override the defaults by providing values for the variables during the plan and apply.

```bash
$ terraform plan --var resource_group_name=rg-charlie --var location=eastus

$ terraform apply --var resource_group_name=rg-charlie --var location=eastus
```

### Using terraform commandline argument `--var-file`
- if you are using any other file name than `terraform.tfvars` then you need to provide `--var-file` option to `terraform plan` and `terraform apply` command.

```bash
$ terraform plan --var dev.tfvars

$ terraform apply --var-file dev.tfvars 
```
Variable helps in achieving code re-usability.
for example if you have the following requests from different teams to create same infrastructure. You can create different `<env>.tfvars` file without changing code.
```bash
# Application Team - Pls provide a resource group for the application deployment for Dev Environment
$ terraform plan --var-file dev.tfvars

# Testing Team     - Pls provide a resource group for the application deployment for QA Environment
$ terraform plan --var-file qa.tfvars

# Integration Team - Pls provide a resource group for the application deployment for Integ Environment
$ terraform plan --var-file integ.tfvars

# PreProd          - Pls provide a resource group for the application deployment for ProProd Environment
$ terraform plan --var-file preprod.tfvars

# Prod             - Pls provide a resource group for the application deployment for Prod Environment
$ terraform plan --var-file prod.tfvars
```

### Using environment variable `TF_VAR_<variable_name>`

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