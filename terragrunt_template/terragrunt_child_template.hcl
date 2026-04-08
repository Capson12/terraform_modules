include "root" {
    path           = find_in_parent_folders()
}

locals {
    parent          = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl")).locals 
    folder_name     = basename(get_terragrunt_dir())
}

dependency "" {
    config_path = ""
}



remote_state {
  backend = "azurerm"
  config = {
    resource_group_name   = local.parent.backend_resource_group
    storage_account_name  = local.parent.backend_storage_account
    container_name        = local.parent.container_name
    key                   = "terraform.state"
  }
}

terraform{
    source = ""
}

######## "Merge" is for when you have dependancy , otherwise use normal inputs format.
# inputs = {


#}

inputs = merge (
    lookup(local.parent, "default_inputs", {}),
    {

    }
)