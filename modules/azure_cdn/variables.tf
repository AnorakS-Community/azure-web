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
variable "storage_account_name" {
  type        = string
  description = "Name given to storage account"
} 

variable "storage_container_name" {
  type        = string
  description = "Name given to storage container"
}

variable "account_tier" {
  type        = string
  description = "Storage Account type in Azure"
}

variable "account_replication_type" {
  type        = string 
  description = "Storage Account replication type in Azure"
}


variable "container_access_type" {
  type        = string
  description = "Permission to gain access to the container"
}


variable "cdn_profile_name" {
  type        = string
  description = "Name of CDN Profile"
}

variable "cdn_sku" {
  type        = string
  description = "SKU"
}

variable "cdn_endpoint_name" {
  type        = string
  description = "CDN Endpoint Name"
}

variable "cdn_endpoint_origin" {
  type        = string
  description = "Azure Web Origin"
}

variable "dns_zone_name" {
  type        = string
  description = "DNS zone name"
}

variable "dns_cname_record_name" {
  type        = string
  description = "Cname Record Name"
}

variable "cname_ttl" {
  type        = number
  description = "Time to Live"
}

variable "endpoint_custom_domain_name" {
  type        = string
  description = "My Custom Domain Name"
}
