## Foundry AWS instance instructions

https://foundryvtt.wiki/en/setup/hosting/Self-Hosting-on-AWS
https://foundryvtt.com/article/nginx/

## Getting started

- authenticate to aws https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration

The terraform.tf file assumes that the administrative account used in creating the infrastructure is named "default", adjust it as needed.

## terraform state

Currently, the project is using local state, more advanced use is out of scope.
This means that the state files describing the resources provisioned by terraform will be saved locally to the working directory.
If you lose the state files, you would have to reimport the resources to terraform to be able to continue managing them with it.

If you want your terraform state to be persisted safely, learn about using [terraform backends](https://www.terraform.io/language/settings/backends).

- TODO: instruct on proper way to create `terraform.auto.tfvars`, maybe a sample file
- TODO: S3 bucket that is only accessible for auth users from VPC, deny any other
- TODO: user to be able to access the S3 bucket
- TODO: user that can start and stop the EC2 instance at will
- TODO: actual app setup (most likely not via TF)

- https://en.wikipedia.org/wiki/Reserved_IP_addresses
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
- https://www.terraform.io/language/functions/cidrsubnet

- secure bucket setup https://aws.amazon.com/blogs/aws/new-vpc-endpoint-for-amazon-s3/