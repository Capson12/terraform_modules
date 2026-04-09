resource "azurerm_resource_group" "main-rg" {
    name = "${var.prefix}"
    location = var.location
}


resource "azurerm_virtual_network" "main-vnet" {
  name = "${var.prefix}-vnet"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name  
}

resource "azurerm_subnet" "main-sub" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main-rg.name
  virtual_network_name = azurerm_virtual_network.main-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}



resource "azurerm_network_interface" "vm-nic" {
  for_each = var.vmnic
  name                = "${each.value.name}-nic"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main-sub.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux" {
  for_each = var.vms
  name                = "${each.value.name}-machine"
  resource_group_name = azurerm_resource_group.main-rg.name
  location            = azurerm_resource_group.main-rg.location
  size                = each.value.size

  network_interface_ids = [
    azurerm_network_interface.vm-nic[each.key].id,
  ]

disable_password_authentication = false
  admin_username = "test_user"
  admin_password = var.password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}