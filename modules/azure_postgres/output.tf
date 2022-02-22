/* Ouput values for Azure Postgresql database */
output "postgresql_database_id" {
  value = azurerm_postgresql_database.postgresql_database.id
}

output "postgresql_database_name" {
  value = azurerm_postgresql_database.postgresql_database.name
}

/* Ouput values for Azure Postgresql server */
output "postgresql_server_id" {
  value = azurerm_postgresql_server.postgresql_server.id
}

output "postgresql_server_name" {
  value = azurerm_postgresql_server.postgresql_server.name
}

output "postgresql_server_fqdn" {
  value = azurerm_postgresql_server.postgresql_server.fqdn
}