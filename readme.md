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

## continued

as I was trying to find out why we couldn't connect to the foundry instance created, I navigated through some UI elements.
decided to compare VPCs, went into each main routing table. there I noticed that the routing table from tf was missing an entry in routes
that had the following config:
Destination: 0.0.0.0/0
Target: igw-0e7bb32b27e9df7a4
Status: Active
Propagated: No

Adding this allowed the ssh connection to the machine. I need to formalize this now in tf code asdf asd