variable "countVMs" {
  type        = number
  default     = 2
  description = "The amount of VMs"
}

variable "resource_group_name" {
  default     = "RG_test"
  description = "Name of the resource group."
}

variable "resource_group_location" {
  default     = "Central US"
  description = "Location of the resource group."
}

variable "vm_size" {
  default     = "Standard_DS1"
  description = "The size of the vm."
}

variable "admin_username" {
  default     = "testadmin"
  description = "Admin user on each VM."
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Admin password on each VM (password SSH login is enabled)."
}
