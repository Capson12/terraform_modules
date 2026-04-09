variable "prefix" {
    type = string
  
}

variable "location" {
    type = string
  
}



variable "vms" {
    type = map(object({
      name = string      
      size = string
      
    }))
  
}

variable "vmnic" {
    type = map(object({
      name = string
    }))
  
}

variable "password" {
    type = string
    sensitive = true
  
}