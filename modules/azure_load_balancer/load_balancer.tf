resource "azurerm_public_ip" "PublicIP" {
  name                = var.public_ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_allocation_method
}

resource "azurerm_lb" "LoadBalancer" {
  name                = var.loadbalancer_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    public_ip_address_id = azurerm_public_ip.PublicIP.id
  }
}

resource "azurerm_lb_backend_address_pool" "BackendAddressPool" {
  loadbalancer_id = azurerm_lb.LoadBalancer.id
  name            = var.backend_address_pool
}

resource "azurerm_lb_nat_rule" "LBNatRule" {
  resource_group_name              = var.resource_group_name
  loadbalancer_id                  = azurerm_lb.LoadBalancer.id
  name                             = var.LB_Nat_name
  protocol                         = var.LB_Nat_protocol
  frontend_port                    = var.frontend_port
  backend_port                     = var.backend_port
  frontend_ip_configuration_name   = var.frontend_ip_name
}