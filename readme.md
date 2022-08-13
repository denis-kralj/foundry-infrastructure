## Foundry AWS instance instructions

https://foundryvtt.wiki/en/setup/hosting/Self-Hosting-on-AWS
https://foundryvtt.com/article/nginx/

## Getting started

- authenticate to aws https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration

The terraform.tf file assumes that the administrative account used in creating the infrastructure is named "default", adjust it as needed.

We are not doing S3 bucket storage until private buckets are supported

## terraform state

Currently, the project is using local state, more advanced use is out of scope.
This means that the state files describing the resources provisioned by terraform will be saved locally to the working directory.
If you lose the state files, you would have to reimport the resources to terraform to be able to continue managing them with it.

If you want your terraform state to be persisted safely, learn about using [terraform backends](https://www.terraform.io/language/settings/backends).

- TODO: instruct on proper way to create `terraform.auto.tfvars`, maybe a sample file
- TODO: document rest of tf files
- TODO: create a swap file

- https://en.wikipedia.org/wiki/Reserved_IP_addresses
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
- https://www.terraform.io/language/functions/cidrsubnet

Questions

can I somehow shorthand the network interface so it isn't defined so verbosely

## Ansible

Using ansible to configure the terraform created resources in order to run foundry

need to find out how to propagate the server ip address to ansible for use
find out how to make the extraction process/transfer of the foundry files visible in ansible UI
ansible assumes the foundry.zip archive to be present in ansible/files/

I'm not using certbot since it doesn't generate certs without domain names

Steps to setup the foundry instance

1. navigate to the `terraform/` directory
1. ensure you have the rights and aws default account properly setup
1. call `terraform init`
1. call `terraform plan -out tfplan`
1. call `terraform apply tfplan`
1. wait for the infrastructure to spin up, note the IP address output
1. navigate to the `ansible/` directory
1. ensure that the supplied SSH key was correct and that you can in fact SSH to the new server
1. update the foundry ip value in `inventory.ini` to the IP address of the server
1. run `ansible-playbook -i inventory.ini playbook.yaml`
1. navigate to the IP address, foundry should be up and running on HTTPS (accept the risk with the unknown cert)
