
# Terraform Modules (personal repo)

This repository contains reusable Terraform modules and related Terragrunt templates maintained by the repository owner. Use these modules to compose, standardise, and provision infrastructure in Azure.

## Purpose

- Centralise shareable Terraform modules used across projects.
- Provide Terragrunt templates to simplify multi-environment composition.

## Repository layout

- `containers/acr/` — module to create Azure Container Registry
- `core/resource_group/` — module to create resource groups
- `monitoring/log-analytics/` — Log Analytics workspace module
- `network/firewall_hub_bastion/` — hub firewall and bastion host module
- `network/peering/` — VNet peering module
- `network/vnet_spoke/` — spoke VNet module
- `terragrunt_template/` — example Terragrunt child/parent templates

Each module folder contains Terraform files: `main.tf`, `variable.tf`, and `output.tf` (when applicable).

## Quickstart — use a module directly

1. Add the module to your Terraform root module, for example:

```hcl
module "example_acr" {
	source = "../containers/acr"

	name                = "my-acr"
	resource_group_name = "rg-example"
	location            = "eastus"
	sku                 = "Standard"
}
```

2. Initialize and apply:

```bash
terraform init
terraform apply
```

## Quickstart — with Terragrunt

Use the templates in `terragrunt_template/` as a starting point.

Example `terragrunt.hcl` for a child:

```hcl
include {
	path = find_in_parent_folders()
}

terraform {
	source = "git::file://${get_terragrunt_dir()}/../network/vnet_spoke"
}

inputs = {
	vnet_name = "example-spoke"
}
```

Then run:

```bash
terragrunt init
terragrunt apply
```

## Conventions

- Modules use input variables defined in `variable.tf` and expose outputs in `output.tf`.
- Keep modules focused and small — one responsibility per module.
- Follow semantic versioning when releasing module versions (if you publish them).

## Testing

- Manual: run `terraform plan` and `terraform apply` in a sandbox subscription.
- Automated: consider integrating `terratest` or a pipeline that runs `terraform validate` and `plan`.

## Contributing

- Create issues or PRs to suggest module improvements or fixes.
- Keep changes small and add documentation for new inputs/outputs.

## License

This repo does not include a license file by default. Add a `LICENSE` if you want to open-source these modules.

---