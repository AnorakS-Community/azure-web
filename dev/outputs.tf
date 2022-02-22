/* AKS Output */
output "kube_config" {
  value       = module.aks.kube_config
  sensitive   = true
  description = "Kube Config Details"
  depends_on  = []
}


/*CDN Output*/
output "cdn_endpoint_id" {
  value = module.azure_cdn.cdn_endpoint_id
  sensitive   = true
  description = "ID of CDN endpoint"
  depends_on  = []
}

output "cdn_profile_id" {
  value = module.azure_cdn.cdn_profile_id
  sensitive   = true
  description = "ID of CDN profile"
  depends_on  = []
}

output "dns_name" {
  value       = module.azure_cdn.dns_name
  sensitive   = true
  description = "CDN DNS name"
  depends_on  = []
}


/*Storage Azccount Output*/
output "storage_account_id" {
  value       = module.azure_storage_account.storage_account_id
  sensitive   = true
  description = "ID of storage account"
  depends_on  = []
}


output "container_name" {
  value       = module.azure_storage_account.container_name
  sensitive   = true
  description = "AZ Storage account container name"
  depends_on  = []
}

output "storage_account_name" {
  value       = module.azure_storage_account.storage_account_name
  sensitive   = true
  description = "Storage Account name"
  depends_on  = []
}

/*Redis Cache Output*/

output "hostname" {
  value       = module.redis_cache.hostname
  sensitive   = true
  description = "Name of redis  cache"
  depends_on  = []
}


/*Postgres Output*/
output "postgresql_database_id" {
  value       = module.azure_postgres.postgresql_database_id
  sensitive   = true
  description = "ID of Postgres database"
  depends_on  = []
}

output "postgresql_database_name" {
  value       = module.azure_postgres.postgresql_database_name
  sensitive   = true
  description = "Name of Postgres database"
  depends_on  = []
}

output "postgresql_server_id" {
  value       = module.azure_postgres.postgresql_server_id
  sensitive   = true
  description = "ID of Postgres Server"
  depends_on  = []
}

output "postgresql_server_name" {
  value       = module.azure_postgres.postgresql_server_name
  sensitive   = true
  description = "Postgres Server Name"
  depends_on  = []
}

output "postgresql_server_fqdn" {
  value       = module.azure_postgres.postgresql_server_fqdn
  sensitive   = true
  description = "Postgres Server Fully Qualified Domain Name"
  depends_on  = []
}

/* SSL */
output "key_vault_name" {
  value       = module.ssl.key_vault_name
  sensitive   = true
  description = "Key Vault Name"
  depends_on  = []
}

output "secret_identifier" {
  value       = module.ssl.secret_identifier
  sensitive   = true
  description = "ID of certificate"
  depends_on  = []
}

output "vnet_id" {
  value       = module.ssl.vnet_id
  sensitive   = true
  description = "ID of virtual network"
  depends_on  = []
}

output "frontend_subnet_id" {
  value       = module.ssl.frontend_subnet_id
  sensitive   = true
  description = "ID of frontend subnet"
  depends_on  = []
}

output "backend_subnet_id" {
  value       = module.ssl.backend_subnet_id
  sensitive   = true
  description = "ID of frontend subnet"
  depends_on  = []
}

/* Load Balancer */
output "PublicIP" {
  value       = module.azure_load_balancer.PublicIP
  sensitive   = true
  description = "ID of Public IPß"
  depends_on  = []
}