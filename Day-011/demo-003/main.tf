variable "mark" {
  description = "Enter marks obtained in maths"
  validation {
    condition     = can(regex("^[1-9][0-9]?$|^100$", var.mark))
    error_message = "Please enter whole number between 0 to 100"
  }
}

variable "my_birth_day" {
  description = "My birth day"

  validation {
    condition     = contains(["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], var.my_birth_day)
    error_message = "[ERROR] Invalid day, Please enter correctly from Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday"
  }
}