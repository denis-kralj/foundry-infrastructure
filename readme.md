## Getting started

- authenticate to aws https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration

The terraform.tf file assumes that the administrative account used in creating the infrastructure is named "default", adjust it as needed.

## terraform state

Currently, the project is using local state, more advanced use is out of scope.
This means that the state files describing the resources provisioned by terraform will be saved locally to the working directory.
If you lose the state files, you would have to reimport the resources to terraform to be able to continue managing them with it.

If you want your terraform state to be persisted safely, learn about using [terraform backends](https://www.terraform.io/language/settings/backends).

TODO: instruct on proper way to create `terraform.auto.tfvars`, maybe a sample file

TODO: we still cannot SSH to the machine

