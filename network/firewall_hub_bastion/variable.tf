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

variable "address_space" {
    description = "The address space for the virtual network"
    type        = list(string)
    default     = ["10.0.0.0/16"]
}


variable "subnet" {
    type = map(object({
      name = string
      subnet_address_prefixes = list(string)

    }))
  
}


variable "routes" {
    type = map(object({
      name = string 
      address_prefix = string
      next_hop = string
      next_hop_in_ip_address = string

    }))
  
}


variable "security_rule" {
    type = map(object({
      name = string
      direction = string
      priority = number
      access = string
      protocol = string
      source_port_range = string
      destination_port_range = string
      source_address_prefix = string
      destination_address_prefix = string


    }))
  
}