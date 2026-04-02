output "virtual_network_id" {
    value = azurerm_virtual_network.vnet_hub.id 
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet_hub.name
}

output "firwall_ip_address" {
  value = azurerm_public_ip.firwall_pubip.ip_address
}