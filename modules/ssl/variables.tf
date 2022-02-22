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

variable "user_assigned_identity_name" {
  type        = string   
  description = "Define the access a user has"
}

variable "key_vault_name" {
  type        = string   
  description = "Name of vault to hold certificats and secrets"
}

variable "soft_delete_retention_days" {
  type          = number    
  description   = "allows recovery of the deleted vaults and objects"
}

variable "sku_name" {
  type          = string     
  description   = "Stock-Keeping-Unit"
}

variable "certificate_permissions" {
  type        = list(string)    
  description = "Permissions granted by the certificate"
}

variable  "key_permissions" {
  type        = list(string)   
  description = "Permissions granted by the key"
}

variable "secret_permissions" {
  type = list(string)    
  description = "Permissions granted by the secret"
}

variable "key_vault_certificate_name" {
  type        = string  
  description = "Name of key vault certificate"
}

variable "name_issuer_parameters" {
  type        = string  
  description = "name issuer parameter"
}

variable "is_key_exportable" {
  type        = bool    
  description = "Determines if the key can be exported"
}

variable "key_size" {
  type        = number   
  description = "size of key"
}

variable "key_type" {
  type        = string   
  description = "type of key"
}

variable "reuse_key" {
  type        = bool   
  description = "determine if we can reuse the created key"
}

variable "lifetime_action_type" {
  type        = string    
  description = "Lifetime Action Type"
}

variable "days_before_expiry" {
  type        = number  
  description = "determine the number of days before the key expires"
}

variable "secret_content_type" {
  type        = string   
  description = "secret_content_type"
}

variable "extended_key_usage" {
  type        = list(string) 
  description = "AZ KeyVault model"
}

variable "key_usage" {
  type        = list(string)   
  description = "determines where to use the key"
}

variable "dns_names" {
  type        = list(string)  
  description = "List of DNS names"
}

variable "subject" {
  type        = string   
  description = "certificate name"
}

variable "validity_in_months" {
  type        = number  
  description = "determine how long the certificate is valid for"
}

variable "vnet_name" {
  type        = string   
  description = "Name given to virtual network"
}

variable "address_space" {
  type        = list(string)    
  description = "Address space of virtual network"
}

variable "frontend_subnet_name" {
  type        = string   
  description = "Name of subnet for frontend services"
}

variable "address_prefixes" {
  type        = list(string)    
  description = "Address space of subnet for frontend services"
}

variable "backend_subnet_name" {
  type        = string    
  description = "Name of subnet for backend services"
}

variable "backend_address_prefixes" {
  type        = list(string)   
  description = "Address space of subnet for backend services"
}

variable "app_gw_network_name" {
  type        = string   
  description = "Name of App Gateway"
}

variable "app_gw_sku_name" {
  type        = string   
  description = "SKU Name"
}

variable "app_gw_sku_capacity" {
  type        = number
  description = "SKU Capacity"
}

variable "app_gw_network_ip" {
  type        = string   
  description = "Gateway network IP configuration"
}

variable ddos_name {
  type        = string   
  description = "DDOs protection name"
}

variable "public_ip_name" {
  type        = string   
  description = "Name of public IP"
}

variable "ip_allocation_method" {
  type        = string    
  description = "How should IP addresses be allocated"
}
