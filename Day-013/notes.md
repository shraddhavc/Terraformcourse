# Topics

- [Terraform State Management](#terraform-state-management)
- [Workspaces](#workspaces)

## Terraform State Management
- ### Terraform State

  Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.
  
  **Terraform State Purpose**
  1. Mapping to the real world infrastructure
  2. Tracking metadata such as dependencies, ordering semantics etc
  3. Performance improvement of terraform operations
  4. Syncing

- ### Backend Configurations
  A backend defines where Terraform stores its `state` data files.
  
  Terraform supports many backend configurations as per provider. We will see only local and remote(`azurerm`). 
  Backend configurations are provided in `terraform` settings block
  
  **local**
  
  `local` is the default backend configuration.
  ```terraform
    terraform {
      backend "local" {
        path = "path_where_you_want_to_save_state_file"
      }
    }
  ```
  [https://www.terraform.io/language/settings/backends/local](https://www.terraform.io/language/settings/backends/local)
  
  **azurerm**
  ```terraform
    terraform {
      backend "azurerm" {
        resource_group_name  = "StorageAccount-ResourceGroup"
        storage_account_name = "projectalphaterraformbackendswesteurope"
        container_name       = "tfstate"
        key                  = "prod.terraform.tfstate"
      }
    }
  ```
  or partial configuration like below and provide configurations file commandline
  ```terraform
    terraform {
      backend "azurerm" {}
    }
  ```
  ```bash
  terraform init \
     --backend-config resource_group_name="StorageAccount-ResourceGroup" \
     --backend-config storage_account_name="projectalphaterraformbackendswesteurope" \
     --backend-config container_name="tfstatee" \
     --backend-config key="prod.terraform.tfstate"
  ```
  or create a backend configuration file as below`prod-backend.config` and provide configurations file commandline
  ```config
     resource_group_name  = "StorageAccount-ResourceGroup"
     storage_account_name = "projectalphaterraformback endswesteurope"
     container_name       = "tfstate"
     key                  = "prod.terraform.tfstate"
  ```
  ```bash
  terraform init \
     --backend-config prod-backend.config
  ```
  [https://www.terraform.io/language/settings/backends/azurerm](https://www.terraform.io/language/settings/backends/azurerm)

## Workspaces
Each Terraform configuration has an associated backend that defines how Terraform executes operations and where Terraform stores persistent data, like state.

The persistent data stored in the backend belongs to a workspace. The backend initially has only one workspace containing one Terraform state associated with that configuration.

**Workspace commands**
```
terraform workspece new <workspace_name>
terraform workspece list
terraform workspece select <workspace_name>
terraform workspece show
terraform workspece delete <workspace_name>
```
[https://www.terraform.io/language/state/workspaces#workspaces](https://www.terraform.io/language/state/workspaces#workspaces)