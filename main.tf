# Existing Resource Group
resource "azurerm_resource_group" "sitedesign-resources" {
  name     = "sde-resources"
  location = "East US"
}

# Existing Storage Account
resource "azurerm_storage_account" "sitedesign-storage-account" {
  name                     = "sdestorageaccount"
  resource_group_name      = azurerm_resource_group.sitedesign-resources.name
  location                 = azurerm_resource_group.sitedesign-resources.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Existing File Share
resource "azurerm_storage_share" "sitedesign-share" {
  name                 = "sde-share"
  storage_account_name = azurerm_storage_account.sitedesign-storage-account.name
  quota                = 100
}

# Virtual Network
resource "azurerm_virtual_network" "sitedesign_vnet" {
  name                = "sitedesign-vnet"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.sitedesign-resources.location
  resource_group_name = azurerm_resource_group.sitedesign-resources.name
}

# Subnet for the Gateway
resource "azurerm_subnet" "sitedesign_gateway_subnet" {
  name                 = "GatewaySubnet" # This name is required for a Gateway Subnet.
  resource_group_name  = azurerm_resource_group.sitedesign-resources.name
  virtual_network_name = azurerm_virtual_network.sitedesign_vnet.name
  address_prefixes     = ["10.10.1.0/24"]

  service_endpoints = ["Microsoft.Storage"]
}

# Public IP Address for the VPN Gateway
resource "azurerm_public_ip" "sitedesign_vpn_gateway_public_ip" {
  name                = "sitedesign-vpn-gateway-ip"
  location            = azurerm_resource_group.sitedesign-resources.location
  resource_group_name = azurerm_resource_group.sitedesign-resources.name
  allocation_method   = "Dynamic"
}

# Virtual Network Gateway for the VPN
resource "azurerm_virtual_network_gateway" "sitedesign_vpn_gateway" {
  name                = "sitedesign-vpn-gateway"
  location            = azurerm_resource_group.sitedesign-resources.location
  resource_group_name = azurerm_resource_group.sitedesign-resources.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.sitedesign_vpn_gateway_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.sitedesign_gateway_subnet.id
  }

  vpn_client_configuration {
    address_space           = ["172.16.201.0/24"]
    vpn_client_protocols    = ["SSTP"]
  }
}

# Adjust the Network settings for the Storage Account
resource "azurerm_storage_account_network_rules" "sitedesign_network_rules" {
  storage_account_id = azurerm_storage_account.sitedesign-storage-account.id

  default_action             = "Deny"
  virtual_network_subnet_ids = [azurerm_subnet.sitedesign_gateway_subnet.id]
}