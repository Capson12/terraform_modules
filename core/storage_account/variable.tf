variable "prefix" {
    description = "value"
    type = string
  
}


variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}

variable "storage_account_name" {
    description = "Name of the storage account"
    type        = string
}

variable "location" {
    description = "Azure region for resources"
    type        = string
}

variable "account_tier" {
    description = "Storage account tier"
    type        = string
    default     = "Standard"
}

variable "account_replication_type" {
    description = "Storage account replication type"
    type        = string
    default     = "LRS"
}

variable "tags" {
    description = "Tags for resources"
    type        = map(string)
    default     = {}
}


variable "container_name" {
    type = map(object({
      name = string
    }))
}