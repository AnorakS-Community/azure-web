resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = var.account_tier 
  account_replication_type = var.account_replication_type
}


resource "azurerm_storage_container" "container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = var.container_access_type 
}


resource "azurerm_cdn_profile" "cdnProfile" {
  name                  = var.cdn_profile_name
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  sku                   = var.cdn_sku
}

resource "azurerm_cdn_endpoint" "cdnEndpoint" {
  name                   = var.cdn_endpoint_name
  profile_name           = azurerm_cdn_profile.cdnProfile.name
  resource_group_name    = var.resource_group_name
  location               = var.resource_group_location

  origin {
    name      = var.cdn_endpoint_origin
    host_name = azurerm_storage_account.storage.primary_blob_host
  }
}
resource "azurerm_dns_zone" "DNSzone" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_dns_cname_record" "Cname" {
  name                = var.dns_cname_record_name
  zone_name           = azurerm_dns_zone.DNSzone.name
  resource_group_name = azurerm_dns_zone.DNSzone.resource_group_name
  ttl                 = var.cname_ttl
  target_resource_id  = azurerm_cdn_endpoint.cdnEndpoint.id
}

resource "azurerm_cdn_endpoint_custom_domain" "Cname_domain" {
  name            = var.endpoint_custom_domain_name
  cdn_endpoint_id = azurerm_cdn_endpoint.cdnEndpoint.id
  host_name       = "${azurerm_dns_cname_record.Cname.name}.${azurerm_dns_zone.DNSzone.name}"
}