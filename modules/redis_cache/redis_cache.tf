resource "azurerm_redis_cache" "Redis" {
  name                = var.redis_cache_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  capacity            = var.redis_capacity
  family              = var.redis_family
  sku_name            = var.redis_sku
  enable_non_ssl_port = var.enable_non_ssl_port

  redis_configuration {
    maxmemory_reserved = var.redis_maxmemory_reserved
    maxmemory_delta    = var.redis_maxmemory_delta
    maxmemory_policy   = var.redis_maxmemory_policy
  }
}

resource "azurerm_redis_firewall_rule" "redis_firewall" {
  name                = var.redis_firewall_name
  redis_cache_name    = azurerm_redis_cache.Redis.name
  resource_group_name = var.resource_group_name
  start_ip            = var.redis_start_ip
  end_ip              = var.redis_end_ip
}
