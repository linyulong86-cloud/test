variable "location" {
  default = "Australia East"
}

variable "resource_group_name" {
  default = "rg-demo-australiaeast"
}

variable "admin_username" {
  default = "azureadmin"
}

variable "admin_password" {
  default = "Password1234!"
}

variable "vm_names" {
  default = [
    "apple",
    "orange", 
    "pizza"
  ]
}