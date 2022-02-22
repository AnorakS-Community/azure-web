data "azurerm_client_config" "current" {}



resource "azurerm_public_ip" "PublicIP" {
  name                = var.public_ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_allocation_method
}


resource "azurerm_key_vault" "key_vault" {
  name                        = var.key_vault_name 
  location                    = var.resource_group_location 
  resource_group_name         = var.resource_group_name 
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days 
  sku_name                    = var.sku_name 

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions   = var.certificate_permissions
    key_permissions           = var.key_permissions
    secret_permissions        = var.secret_permissions
  }
}


resource "azurerm_key_vault_certificate" "key_vault_certificate" {
  name            = var.key_vault_certificate_name 
  key_vault_id    = azurerm_key_vault.key_vault.id

  certificate_policy {
    issuer_parameters {
      name = var.name_issuer_parameters 
    }

  key_properties {
        exportable = var.is_key_exportable 
        key_size   = var.key_size 
        key_type   = var.key_type 
        reuse_key  = var.reuse_key 
      }
  
  lifetime_action {
      action {
        action_type = var.lifetime_action_type 
      }
  
  trigger {
        days_before_expiry = var.days_before_expiry 
      }
    }
  
  secret_properties {
      content_type = var.secret_content_type 
    }

  /* a key vault model */
  x509_certificate_properties {
    # Server Authentication = 1.3.6.1.5.5.7.3.1
    # Client Authentication = 1.3.6.1.5.5.7.3.2
    extended_key_usage = var.extended_key_usage 
    key_usage = var.key_usage 

    subject_alternative_names {
        dns_names = var.dns_names 
      }

    subject               = var.subject 
      validity_in_months  = var.validity_in_months 
    }
  }
}

resource "azurerm_virtual_network" "myVnet" {
  name                = var.vnet_name 
  resource_group_name = var.resource_group_name 
  location            = var.resource_group_location 
  address_space       = var.address_space 
}


resource "azurerm_subnet" "frontend" {
  name                 = var.frontend_subnet_name 
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.myVnet.name
  address_prefixes     = var.address_prefixes 
}

resource "azurerm_subnet" "backend" {
  name                 = var.backend_subnet_name 
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.myVnet.name
  address_prefixes     = var.backend_address_prefixes 
}


#since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.myVnet.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.myVnet.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.myVnet.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.myVnet.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.myVnet.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.myVnet.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.myVnet.name}-rdrcfg"
}

resource "azurerm_application_gateway" "app_gw_network" { 
  name                      = var.app_gw_network_name 
  location                  = var.resource_group_location 
  resource_group_name       = var.resource_group_name 
  

  sku {
    name     = var.app_gw_sku_name 
    tier     = var.app_gw_sku_name 
    capacity = var.app_gw_sku_capacity 
  }

  gateway_ip_configuration {
    name      = var.app_gw_network_ip 
    subnet_id = azurerm_subnet.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.PublicIP.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name           = "app_listener"
  }

  
  ssl_certificate {
    name = "app_listener"
    key_vault_secret_id = azurerm_key_vault_certificate.key_vault_certificate.secret_id
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
}
}

resource "azurerm_network_ddos_protection_plan" "myddos" {
  name                      = var.ddos_name
  location                  = var.resource_group_location 
  resource_group_name       = var.resource_group_name 
}