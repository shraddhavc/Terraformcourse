# Topics
- [Remote terraform modules](#remote-terraform-modules)
- [Versioning terraform modules](#versioning-terraform-modules)
- [Terraform best practices](#terraform-best practices)
- [Security scanning for terraform modules](#security-scanning-for-terraform-modules)
- [Some useful links](#some-useful-links)

## Remote terraform modules
- Create an empty git repository and clone the repository to your laptop or desktop
- Write a generic terraform module 
- Create a README.md file describing purpose of module, required providers, dependencies, resources created by the module, inputs and outputs of the module etc.
- commit the code and create a tag and push tag to remote git repository.

  Example.
  ```bash
    $ git clone https://github.com/<your_username>/azurerm-vnet-module.git
    $ cd azurerm-vnet-module
    $ touch main.tf variables.tf outputs.tf locals.tf .gitignore README.md
    $ # Write terraform configuration code in these files
    $ # Add .gitignore file for terraform
    $ git status
    $ git add .
    $ git commit -m "Commit message"
    $ git push origin main
    $ git tag -a -m "Terraform module for vnet" v0.0.1
    $ git push origin v0.0.1
  ```
## Versioning terraform modules
If you want to update the existing terraform module then update a module and create a new tag for new version.
   
   Example.
  ```bash
    $ cd azurerm-vnet-module
    $ # Update your terraform module and README.md
    $ git status
    $ git add .
    $ git commit -m "Added new feature to the module"
    $ git push origin main
    $ git tag -a -m "Added subnets" v0.0.2
    $ git push origin v0.0.2
  ```

You can refer the module as below
```terraform
module "vnet" {
  source = "git::https://github.com/<your_username>/azurerm-vnet-module.git?ref=v0.0.2"
  ...
}
```

## Terraform best practices

- [https://www.terraform-best-practices.com](https://www.terraform-best-practices.com)
- [https://docs.cloudposse.com/reference/best-practices/terraform-best-practices](https://docs.cloudposse.com/reference/best-practices/terraform-best-practices)

## Security scanning for terraform modules
- [https://github.com/aquasecurity/trivy](https://github.com/aquasecurity/trivy)
- [https://github.com/tenable/terrascan](https://github.com/tenable/terrascan)

## Some useful links
- **Automatically generate documentation:**
  `terraform-docs` is a tool that does the generation of documentation from Terraform modules in various output formats

  [https://github.com/terraform-docs/terraform-docs](https://github.com/terraform-docs/terraform-docs)

- **Terraform code from existing infrastructure:**
  
  [https://github.com/GoogleCloudPlatform/terraformer](https://github.com/GoogleCloudPlatform/terraformer)

- **Terragrunt:**
  
  [https://terragrunt.gruntwork.io/docs/](https://terragrunt.gruntwork.io/docs/)

- **AzureRM terraform module repository:**

  [https://github.com/terraform-azurerm-modules/](https://github.com/terraform-azurerm-modules/)