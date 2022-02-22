output "secret_identifier" {
  value = azurerm_key_vault_certificate.key_vault_certificate.secret_id
  sensitive   = true
  description = "ID of certificate"
  depends_on  = []
}

output key_vault_name {
  value       = azurerm_key_vault.key_vault.name
  sensitive   = true
  description = "description"
  depends_on  = []
}

output "vnet_id" {
  value       = azurerm_virtual_network.myVnet.id
  sensitive   = true
  description = "ID of virtual network"
  depends_on  = []
}

output "frontend_subnet_id" {
  value       = azurerm_subnet.frontend.id
  sensitive   = true
  description = "ID of frontend subnet"
  depends_on  = []
}

output "backend_subnet_id" {
  value       = azurerm_subnet.backend.id
  sensitive   = true
  description = "ID of backend subnet"
  depends_on  = []
}


