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

/* Azure PostgreSQL */
variable "postgresql_database_name" {
  type        = string
  description = "PostgreSQL Name"
}

variable "charset"  {
  type        = string 
  description = "Character set"
}


variable "collation" {
  type        = string 
  description = "Collation"
}


/* Variable for Azure Postgresql server */
variable "postgresql_server_name"  {
  type        = string  
  description = "PostgreSQL Server Name"
}

variable "postgresql_server_sku_name" {
  type        = string
  description = "PostgreSQL Server SKU name"
}

variable "postgresql_server_version" {
  type        = string 
  description = "PostgreSQL Server version"
}

variable "administrator_login" {
  type        = string
  description = "Admin username"
}

variable "administrator_login_password" {
  type        = string  
  description = "Admin Password"
}

variable "auto_grow_enabled" {
  type        = bool  
  description = "Auto grow Enabled"
}

variable "storage_mb" {
  type        = number
  description = "Amount of Storage MB"
}

variable "backup_retention_days"  {
  type        = number 
  description = "backup retention days" 
}

variable "geo_redundant_backup_enabled" {
  type        = bool  
  description = "geo redundant backup enabled"
}

variable "ssl_enforcement_enabled" {
  type        = bool 
  description = "SSL Enforcement"
}

variable "public_network_access_enabled" {
  type        = bool 
  description = "public_network_access_enabled"
}

variable "ssl_minimal_tls_version_enforced" {
  type        = string 
  description = "ssl_minimal_tls_version_enforced"
}

variable "postgresql_configuration_name" {
  type        = string 
  description = "description"
}

variable "postgresql_value" {
  type        = string  
  description = "postgresql_value"
}

variable "postgresql_firewall_name" {
  type        = string 
  description = "postgresql firewall"
}

variable "postgresql_start_ip" {
  type        = string 
  description = "postgresql_start_ip"
}

variable "postgresql_end_ip"  {
  type        = string
  description = "postgresql_end_ip" 
}
