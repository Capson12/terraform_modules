resource "azurerm_virtual_network" "vnet_spoke" {
  name                      = "${var.prefix}-vnet"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  address_space             = var.address_space
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_spoke.name
  address_prefixes    = var.subnet_address_prefix
}
