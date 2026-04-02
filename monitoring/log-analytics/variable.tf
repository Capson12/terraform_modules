variable "prefix" {
  description = "Prefix for all resources in this module"
  type        = string
  default     = "fw"
  
}

variable "location" {
    description = "Azure region where the resources will be created"
    type        = string
    default     = "uksouth"
  
}

variable "resource_group_name" {
    description = "Name of the resource group where the resources will be created"
    type        = string

}
