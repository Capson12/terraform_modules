resource "azurerm_log_analytics_workspace" "log-main" {
  name = "${var.prefix}-log-workspace"
  location = var.location
  resource_group_name = var.resource_group_name
  
}