# Validation Example
/*
Validates each object in the list
*/

variable "inline_policies" {
  default = [
    {
      name                    = "policy1"
      inline_policy_file_path = "./policy1.json"
    },
    {
      name                    = "policy2"
      inline_policy_file_path = "./policy2.json"
    },
    {
      name                    = "policy3"
      inline_policy_file_path = "./policy3.json"
    }
  ]
  validation {
    condition     = alltrue([for inline_policy in var.inline_policies : false if !fileexists(inline_policy.inline_policy_file_path)])
    error_message = "[Error]: One of the inline_policy_file_path does not exist."
  }
}