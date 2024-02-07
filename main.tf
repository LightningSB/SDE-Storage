# Create a Resource Group
resource "azurerm_resource_group" "sitedesign-resources" {
  name     = "sde-resources"
  location = "East US"
}

# Create a Storage Account
resource "azurerm_storage_account" "sitedesign-storage-account" {
  name                     = "sdestorageaccount"
  resource_group_name      = azurerm_resource_group.sitedesign-resources.name
  location                 = azurerm_resource_group.sitedesign-resources.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a File Share
resource "azurerm_storage_share" "sitedesign-share" {
  name                 = "sde-share"
  storage_account_name = azurerm_storage_account.sitedesign-storage-account.name
  quota                = 100  # Set the quota for the file share in GB
}
