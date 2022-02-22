terraform {
  backend "remote" {
    hostname     = ""
    organization = ""
    workspaces {
      name = ""
    }
  }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

# Azure Key Vault Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

locals {
  common_tags = {
    BusinessTower      = ""
    BuinessSegmenet    = ""
    Service            = ""
    FMC                = ""
    BillingApprover    = ""
    SupportGroup       = ""
    Environment        = "dev"
    "PreserveResource" = ""
  }
  apmid_tag = {
    APMID = ""
  }
  resource_group_location = "us-east-1"
  resource_group_name     = ""
  app_name            = "app${random_id.random_id.hex}"
  domain              = ""
  api_subdomain       = "api.${local.domain}"
  redis_subdomain     = "redis.${local.domain}"
}

resource "random_id" "random_id" {
  byte_length = 4
}

module "aks" {
  source                                = "../modules/aks"
  resource_group_location               = local.resource_group_location
  resource_group_name                   = local.resource_group_name
  kubernetes_cluster_name               = "${local.app_name}-webK8sCluster"
  aks_dns_prefix                        = "aks-${local.app_name}"
  kubernetes_version                    = ""
  aks_default_node_pool_name            = "${local.app_name}-aks"
  aks_vm_size                           = "Standard_D2s_v3"
  aks_identity_type                     = "SystemAssigned"
  tags                                  = "${var.common_tags["Environement"]}"
}

module "azure_cdn" {
  source                        = "../modules/azure_cdn"
  resource_group_location       = local.resource_group_location
  resource_group_name           = local.resource_group_name
  storage_account_name          = "${local.app_name}"
  storage_container_name        = "${local.app_name}"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  container_access_type         = "private" 
  cdn_profile_name              = "${local.app_name}"
  cdn_sku                       = "Standard_Verizon" 
  cdn_endpoint_name             = "${local.app_name}"
  cdn_endpoint_origin           = "" 
  dns_zone_name                 = local.domain  
  dns_cname_record_name         = "" 
  cname_ttl                     = 3600
  endpoint_custom_domain_name   = local.domain 
  tags                          = "${var.common_tags["Environement"]}"
}

module "azure_load_balancer" {
  source                          = "../modules/azure_load_balancer"
  resource_group_location         = local.resource_group_location
  resource_group_name             = local.resource_group_name
  public_ip_name                  =   "${local.app_name}"
  ip_allocation_method            =   "Static"
  loadbalancer_name               =   "${local.app_name}"
  frontend_ip_name                =   "${local.app_name}"
  backend_address_pool            =   "BackendAddressPool"
  LB_Nat_name                     =   "${local.app_name}"
  LB_Nat_protocol                 =   "Tcp"
  frontend_port                   =   3389
  backend_port                    =   3389
  tags                            = "${var.common_tags["Environement"]}"
}

module "azure_postgres" {
    source                                  = "../modules/azure_postgres"
    resource_group_location                 = local.resource_group_location
    resource_group_name                     = local.resource_group_name
    postgresql_database_name                = "${local.app_name}"
    charset                                 = "UTF8"
    collation                               = ""
    postgresql_server_name                  = "${local.app_name}"
    postgresql_server_sku_name              = "${local.app_name}"
    postgresql_server_version               = "11"
    administrator_login                     = ""
    administrator_login_password            = ""
    auto_grow_enabled                       = true
    storage_mb                              = 5120
    backup_retention_days                   = 7
    geo_redundant_backup_enabled            = false
    ssl_enforcement_enabled                 = true
    postgresql_configuration_name           = "${local.app_name}" 
    postgresql_value                        = "on"  
    postgresql_firewall_name                = "${local.app_name}"
    postgresql_start_ip                     = ""
    postgresql_end_ip                       = ""
    ssl_minimal_tls_version_enforced        = "TLS1_2"
    tags                                    = "${var.common_tags["Environement"]}"
    public_network_access_enabled           = false
}



module "redis_cache" {
  source                          = "../modules/redis_cache"
  resource_group_location         = local.resource_group_location
  resource_group_name             = local.resource_group_name
  redis_cache_name                = "${local.app_name}"
  redis_capacity                  = 1
  redis_family                    = "P"
  redis_sku                       = "Premium"
  enable_non_ssl_port             = false
  redis_maxmemory_reserved        = 2
  redis_maxmemory_delta           = 2
  redis_maxmemory_policy          = ""
  redis_firewall_name             = "${local.app_name}"
  redis_start_ip                  =  ""
  redis_end_ip                    = ""
  tags                            = "${var.common_tags["Environement"]}"
 }

module "ssl" {
  source                              = "../modules/ssl"
  resource_group_location             = local.resource_group_location
  resource_group_name                 = local.resource_group_name
  user_assigned_identity_name         = "${local.app_name}"
  key_vault_name                      = "${local.app_name}"
  soft_delete_retention_days          = 7
  sku_name                            = ""

  certificate_permissions             = ["create",
                                          "delete",
                                          "deleteissuers",
                                          "get",
                                          "getissuers",
                                          "import",
                                          "list",
                                          "listissuers",
                                          "managecontacts",
                                          "manageissuers",
                                          "purge",
                                          "setissuers",
                                          "update",]

  key_permissions                     = ["backup",
                                          "create",
                                          "decrypt",
                                          "delete",
                                          "encrypt",
                                          "get",
                                          "import",
                                          "list",
                                          "purge",
                                          "recover",
                                          "restore",
                                          "sign",
                                          "unwrapKey",
                                          "update",
                                          "verify",
                                          "wrapKey", ]

  secret_permissions                  = ["backup",
                                          "delete",
                                          "get",
                                          "list",
                                          "purge",
                                          "recover",
                                          "restore",
                                          "set", ]

  key_vault_certificate_name          = "${local.app_name}"
  name_issuer_parameters              = "Self"
  is_key_exportable                   = true
  key_size                            = 2048
  key_type                            = "RSA"
  reuse_key                           = true
  lifetime_action_type                = "AutoRenew"
  days_before_expiry                  = 30
  secret_content_type                 = "application/x-pkcs12"
  extended_key_usage                  = ["1.3.6.1.5.5.7.3.1"]
  key_usage                           = [
                                          "cRLSign",
                                          "dataEncipherment",
                                          "digitalSignature",
                                          "keyAgreement",
                                          "keyCertSign",
                                          "keyEncipherment",
                                      ]

  dns_names                           = [local.domain, local.domain]
  subject                             = "CN=hello-world"
  validity_in_months                  =  12
  vnet_name                           = ""
  address_space                       = ["10.254.0.0/16"]
  frontend_subnet_name                = "${local.app_name}"
  address_prefixes                    = ["10.254.0.0/24"]
  backend_subnet_name                 = "${local.app_name}"
  backend_address_prefixes            = ["10.254.2.0/24"]
  app_gw_network_name                 = "${local.app_name}"
  app_gw_sku_name                     = ""
  app_gw_sku_capacity                 = 2
  app_gw_network_ip                   = "${local.app_name}"
  ddos_name                           = "${local.app_name}"
  tags                                = "${var.common_tags["Environement"]}"
} 