provider "local" {}

variable "content" {
  default = <<EOT
  This is sample content.
  Created by the Terraform code.
  Do not delete or modify it.
EOT
}

resource "local_file" "this" {
  filename = "${path.root}/sample.txt"
  content  = var.content
}

resource "local_file" "that" {
  filename = "${path.root}/out.txt"
  content  = "The ID of \"${local_file.this.filename}\" is  ${local_file.this.id}" # Interpolation

  depends_on = ["local_file.this"]
}

output "secret_file_id" {
  value     = local_file.that.id
  sensitive = true
}
