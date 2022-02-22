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

variable "public_ip_name" {
  type        = string   
  description = "Name of public IP"
}

variable "ip_allocation_method" {
  type        = string  
  description = "How should IP addresses be allocated"
}

variable "loadbalancer_name"{
  type        = string  
  description = "Define the name of the Load Balancer"
}

variable "frontend_ip_name" {
  type        = string 
  description = "Public IP for frontend"
}

variable "backend_address_pool" {
  type        = string  
  description = "Backend Address Pool"
}

variable "LB_Nat_name" {
  type        = string 
  description = "description"
}

variable "LB_Nat_protocol" {
  type        = string  
  description = "Load Balancer protocol"
}

variable "frontend_port" {
  type        = number  
  description = "Frontend Port"
}

variable "backend_port" {
  type        = number   
  description = "Backend Port"
}
