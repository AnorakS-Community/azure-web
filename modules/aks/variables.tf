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

variable "kubernetes_cluster_name" {
  type            = string
  description     = "Name of Kubernetes Cluster"
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS name"
}

variable "kubernetes_version" {
  type        = string
  description = "Define Kubernetes Version"
}

variable "aks_default_node_pool_name" {
  type        = string
  description = "Name of worker nodes"
}

variable "node_count" {
  type        = number
  description = "Number of pods to create"
}

variable "aks_vm_size" {
  type        = string
  description = "Size of Worker nodes"
}

variable "aks_identity_type" {
  type        = string
  description = "Type of identity"
}
