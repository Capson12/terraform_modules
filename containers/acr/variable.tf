variable "prefix" {
    description = "name of resource"
    type = string
}

variable "location" {
    description = "location resource"
    type = string
  
}

variable "resource_group_name" {
    description = "name of resource group"
    type = string
  
}

variable "sku" {
    description = "sku type"
    type = string
    default = "Standard"
  
}