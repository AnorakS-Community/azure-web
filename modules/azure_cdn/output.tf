output "cdn_endpoint_id" {
  value = azurerm_cdn_endpoint.cdnEndpoint.id
  sensitive   = true
}

output "cdn_profile_id" {
  value = azurerm_cdn_profile.cdnProfile.id
  sensitive   = true
}

output "dns_name" {
  value       = azurerm_dns_zone.DNSzone.name
  sensitive   = false
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
  sensitive   = true
}

output "container_name" {
  value       = azurerm_storage_container.container.name
  sensitive   = false
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
  sensitive   = false
}
