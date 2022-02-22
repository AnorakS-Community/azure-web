variable "resource_group_name" {
  type        = string
  description = "Name of collection of all resources created in the same region"
}  

variable "resource_group_location" {
  type        = string
  description = "Location of resource group"
}

variable "tags" {
  type        = string
  description = "Tag, for easy identification of resources"
}

variable "redis_cache_name" {
  type          = string    
  description   = "Redis Cache Name"
}

variable "redis_capacity" {
  type          = string   
  description   = "Redis Capacity"
}

variable "redis_family" {
  type            = string     
  description     = "Redis Family"
}

variable "redis_sku" {
  type            = string     
  description     = "SKU"
}

variable "enable_non_ssl_port" {
    type        = bool
 
    description = "Enable non SSL Port"
}


variable "redis_maxmemory_reserved" {
  type        = number   
  description = "maxmemory_reserved"
}

variable "redis_maxmemory_delta" {
  type        = number   
  description = "maxmemory_delta"    
}

variable "redis_maxmemory_policy" {
  type        = string  
  description = "maxmemory_policy"
}

variable "redis_firewall_name" {
  type        = string   
  description = "redis_firewall_name"
}

variable "redis_start_ip" {
  type        = string  
  description = "Redis Start IP"
}

variable "redis_end_ip" {
  type        = string  
  description = "Redis End IP"
}
