<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.26.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~>0.8.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~>4.0.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.26.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.8.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [time_static.this](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location of the resource. | `string` | `"westeurope"` | no |
| <a name="input_os_profile"></a> [os\_profile](#input\_os\_profile) | n/a | <pre>object({<br>    admin_username = string<br>    computer_name  = string<br>  })</pre> | n/a | yes |
| <a name="input_os_profile_linux_config"></a> [os\_profile\_linux\_config](#input\_os\_profile\_linux\_config) | n/a | <pre>object({<br>    disable_password_authentication = string<br>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix to use for the infrastructure | `string` | `"alpha"` | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | Private IP allocation method, Either Static or Dynamic | `any` | n/a | yes |
| <a name="input_public_ip_allocation_method"></a> [public\_ip\_allocation\_method](#input\_public\_ip\_allocation\_method) | Public IP allocation method, Either Static or Dynamic | `string` | n/a | yes |
| <a name="input_storage_image_reference"></a> [storage\_image\_reference](#input\_storage\_image\_reference) | Storage image reference configuration block. | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | n/a | yes |
| <a name="input_storage_os_disk"></a> [storage\_os\_disk](#input\_storage\_os\_disk) | Storage OS disk configuration block | <pre>object({<br>    name              = string<br>    caching           = string<br>    create_option     = string<br>    managed_disk_type = string<br>  })</pre> | n/a | yes |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | Subnet address prefixes. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags of the resource. | `map(any)` | n/a | yes |
| <a name="input_virtual_network_address_space"></a> [virtual\_network\_address\_space](#input\_virtual\_network\_address\_space) | Virtual network address space. | `list(string)` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the virtual machine | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | Private key date |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP address of the virtual machine |
<!-- END_TF_DOCS -->