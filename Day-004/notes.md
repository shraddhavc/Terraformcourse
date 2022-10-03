# Structure your code

Create separate files for providers, variables, locals, outputs etc
This helps in managing your code and also improves readability of the code.

Good proactive is to create files as follows

```
providers.tf
locals.tf
variables.tf
outputs.tf
main.tf
```


if you are using `terraform.tfvars` file to provide values for the input variables then you don't need to provide `--var-file` option to `terraform plan` and `terraform apply` command