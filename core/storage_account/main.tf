resource "azurerm_storage_account" "main-storage" {
  name = "${var.prefix}storageaccount"
  location = var.location
  resource_group_name = var.resource_group_name
  account_tier = var.account_tier
  account_replication_type = "ZRS"

  
}

resource "azurerm_storage_container" "main_container" {
  for_each = var.container_name
  name = "${each.value.name}container"
  storage_account_id = azurerm_storage_account.main-storage.id
  container_access_type = "private"

  
}