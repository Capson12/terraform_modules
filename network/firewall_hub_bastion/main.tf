###############################
# Firewall (Hub) module
###############################

resource "azurerm_virtual_network" "vnet_hub" {
  name                      = "${var.prefix}-vnet"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  address_space             = var.address_space
}

resource "azurerm_subnet" "subnet-" {
  for_each = var.subnet
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes    = each.value.subnet_address_prefixes
  
}


resource "azurerm_firewall" "firewall-main" {
  name = "${var.prefix}-fw"
  location = var.location
  resource_group_name = var.resource_group_name
  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  ip_configuration {
    name = "${var.prefix}-firwall-ipconfig"
    subnet_id = azurerm_subnet.subnet-["AzureFirewallSubnet"].id
    public_ip_address_id = azurerm_public_ip.firwall_pubip.id
  }
  
}

resource "azurerm_public_ip" "firwall_pubip" {
  name = "${var.prefix}-firwall-pubip"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku = "Standard"
  
}



####################
# Bastion Host
####################


resource "azurerm_bastion_host" "bastion_host" {
  name = "${var.prefix}-bastion"
  location = var.location
  resource_group_name = var.resource_group_name


  ip_configuration {
    name = "${var.prefix}-bastion-ipconfig"
    subnet_id = azurerm_subnet.subnet-["bastion"].id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
  
  
}

resource "azurerm_public_ip" "public_ip" {
  name = "${var.prefix}-public-ip"
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku = "Standard"
}



####################
# Routing & Security 
####################
resource "azurerm_route_table" "route-table" {
  name                = "${var.prefix}-route-table"
  location            = var.location
  resource_group_name = var.resource_group_name
  
   dynamic "route" {
    for_each = var.routes 
    content {
      name = route.value.name
      address_prefix = route.value.address_prefix
      next_hop_type = route.value.next_hop
      next_hop_in_ip_address = (
        lookup(route.value, "next_hop_in_ip_address", null) == "firewall"
        ? azurerm_firewall.firewall-main.ip_configuration[0].private_ip_address
        : lookup(route.value, "next_hop_in_ip_address", null)
      )
    }
  }

}



resource "azurerm_network_security_group" "nsg" {
  name = "${var.prefix}-nsg"
  resource_group_name = var.resource_group_name
  location = var.location

  dynamic "security_rule" {
  for_each  = var.security_rule
  content {

    name                       =  security_rule.value.name
    priority                   =  security_rule.value.priority
    direction                  =  security_rule.value.direction
    access                     =  security_rule.value.access
    protocol                   =  security_rule.value.protocol
    source_port_range          =  security_rule.value.source_port_range
    destination_port_range     =  security_rule.value.destination_port_range
    source_address_prefix      =  security_rule.value.source_address_prefix 
    destination_address_prefix =  security_rule.value.destination_address_prefix
    
    }
  }
  
  
}