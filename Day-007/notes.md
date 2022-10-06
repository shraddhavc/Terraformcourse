# Topics

- [Data sources](#data-sources)
- [Provisioners](#provisioners)

## Data Sources
Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

[https://www.terraform.io/language/data-sources](https://www.terraform.io/language/data-sources)


## Provisioners
Provisioners are used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.

Provisioners use SSH or WinRM to interact with remote servers.

Most of the cloud provider provides mechanism to pass data to the services at boot time as an alternative to provisioner.
For Example, Microsoft Azure has `custom_data` on `azurerm_virtual_machine` or `azurerm_virtual_machine_scale_set`

_**Note**: Provisioners should only be used as a last resort. For most common situations there are better alternatives. For more information, see the sections above._

[https://www.terraform.io/language/resources/provisioners/syntax](https://www.terraform.io/language/resources/provisioners/syntax)

There are 3 types of provisioner for AzureRM
- file
- local-exec 
- remote-exec

### File Provisioner
The file provisioner copies files or directories from the machine running Terraform to the newly created resource. The file provisioner supports both `ssh` and `winrm` type connections.
The remote-exec provisioner requires a `connection` and supports both `ssh` and `winrmExample`
```terraform
provisioner "file" {
    source      = "conf/application.conf"
    destination = "/etc/application.conf"
    connection {
        type = "ssh"
        host = "103.50.0.3"
        user = "systemadmin"
        private_key = "c3lzdGVtYWRtaW4K"
    }
}
```

### Local-Exec Provision
The local-exec provisioner invokes a local executable after a resource is created. This invokes a process on the machine running Terraform,
Example
```terraform
provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
}
```

### Remote-Exec
The remote-exec provisioner invokes a script on a remote resource after it is created. This can be used to run a configuration management tool, bootstrap into a cluster, etc.
The remote-exec provisioner requires a `connection` and supports `both` ssh and `winrm`

```terraform
  connection {
    type     = "ssh"
    user     = var.admin_password
    password = var.admin_password
    host     = azurerm_public_ip.example.ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
```

