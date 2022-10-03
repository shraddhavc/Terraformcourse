# Referencing th list

provider "local" {}
provider "random" {}

variable "filenames" {
  description = "Filenames for the file"
  type        = list(string)
  default     = ["zero.txt", "one.txt", "two.txt", "three.txt", "four.txt", "five.txt"]
}

resource "random_integer" "this" {
  min = 0
  max = 5
}

resource "local_file" "this" {
  filename = var.filenames[random_integer.this.result]
  content  = "This is a sample file"
}

output "index" {
  value = random_integer.this.result
}





