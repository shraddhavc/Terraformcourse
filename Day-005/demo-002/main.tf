# Referencing th map

variable "file" {
  type = map(any)
  default = {
    filename = "sample.txt"
    content  = "This is a sample file"
  }
}

resource "local_file" "this" {
  filename = var.file["filename"]
  content  = var.file["content"]
}

# This also works
#resource "local_file" "this" {
#  filename = var.file.filename
#  content = var.file.content
#}
