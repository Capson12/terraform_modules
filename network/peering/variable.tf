variable "prefix" {
    description = "Name of resource"
    type = string
  
}

variable "resource_group_name" {
    description = "Resouce Group name"
    type = string
  
}

variable "virtual_network_name_hub" {
    description = "Name of the Virtual network Hub"
    type = string
  
}

variable "virtual_network_name_spoke" {
    type = string
  
}


variable "hub_vnet_id" {
    type = string
  
}

variable "spoke_vnet_id" {
    type = string
  
}