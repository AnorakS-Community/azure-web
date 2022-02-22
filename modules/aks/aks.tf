resource "azurerm_kubernetes_cluster" "cluster" {
  name                    = var.kubernetes_cluster_name
  location                = var.resource_group_location
  dns_prefix              = var.aks_dns_prefix
  resource_group_name     = var.resource_group_name
  kubernetes_version      = var.kubernetes_version

  default_node_pool {
    name       = var.aks_default_node_pool_name
    node_count = var.node_count
    vm_size    = var.aks_vm_size
  }

  identity {
    type = var.aks_identity_type
  }
}
