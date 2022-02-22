output "PublicIP" {
  value       = azurerm_public_ip.PublicIP.id
  sensitive   = true
  description = "ID of Public IP"
  depends_on  = []
}
