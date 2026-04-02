resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name = "${var.prefix}-to-spoke"
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name_hub
  remote_virtual_network_id = var.spoke_vnet_id
  
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name = "${var.prefix}-to-spoke"
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name_spoke
  remote_virtual_network_id = var.hub_vnet_id
  
}