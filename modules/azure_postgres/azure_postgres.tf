resource "azurerm_postgresql_database" "postgresql_database" {
  name                = var.postgresql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql_server.name 
  charset             = var.charset
  collation           = var.collation
}

resource "azurerm_postgresql_server" "postgresql_server" {
  name                         = var.postgresql_server_name
  location                     = var.resource_group_location
  resource_group_name          = var.resource_group_name
  sku_name                     = var.postgresql_server_sku_name
  version                      = var.postgresql_server_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  auto_grow_enabled            = var.auto_grow_enabled
  storage_mb                   = var.storage_mb
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  ssl_enforcement_enabled      = var.ssl_enforcement_enabled
  tags                             = var.tags
  public_network_access_enabled    = var.public_network_access_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced
}


resource "azurerm_postgresql_configuration" "postgresql_config" {
  name                  = var.postgresql_configuration_name
  resource_group_name   = var.resource_group_name
  server_name           = azurerm_postgresql_server.postgresql_server.name
  value                 = var.postgresql_value
}

resource "azurerm_postgresql_firewall_rule" "postgresql_firewall" {
  name                  = var.postgresql_firewall_name
  resource_group_name   = var.resource_group_name
  server_name           = azurerm_postgresql_server.postgresql_server.name
  start_ip_address      = var.postgresql_start_ip
  end_ip_address        = var.postgresql_end_ip
} 