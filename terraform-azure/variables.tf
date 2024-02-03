variable "countVMs" {
  default       = "2" #change to create more VMs
  description   = "The amount of VMs"
}

variable "resource_group_name_prefix" {
  default       = "rg"
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resource_group_location" {
  default       = "Central US"
  description   = "Location of the resource group."
}

variable "vm_size" {
  default       = "Standard_DS1"
  description   = "The size of the vm."
}
