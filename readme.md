# FoundryVTT on AWS + Gandi DNS record

## Requirements

- [Terraform](https://www.terraform.io/)
- [Ansible](https://www.ansible.com/)

## Prerequisites

This solution assumes that you have an AWS account setup on the executing machine that has rights to create and delete AWS resources named 'default'. It also assumes use of gandi.net as a domain name provider that can have their DNS records updated to give a human readable URL to players for their use.

An example file named `terraform.auto.tfvars.example` contains all variables used for the infrastructure, adjust to your own needs. These entries are required in either the auto.tfvars, entered in the interactive shell or as command line arguments in order for the system to work properly.

Ansible requires several files to work:
- a zip archive `foundry.zip` with the foundry release binary (this can be downloaded from the FoundryVTT website in the 'Purchased Software Licenses' page)
- `cert.pem` and `key.pem` files that are used for SSL encryption of web traffic to the server

This solution was tested with Foundry VTT v11 and is not guaranteed to work with other versions.

## Use

This repository allows the user to spin up infrastructure in order to host a private instance of FoundryVTT. The infrastructure created is free tier eligible.

Navigate to the `terraform/` directory and use the following commands:

```bash
terraform init
terraform apply

# type in 'yes' when prompted
```

The script generates an inventory file in the `ansible/` directory that should be used in the next step.

Navigate to the `ansible/` directory and use the following command:

```bash
ansible-playbook -i inventory.yaml playbook.yaml
```

At the end of execution the command will give you an address to navigate to. From there setup the foundry instance as usual.

When done, you can delete the infrastructure by simply destroying resources via terraform. Navigate to the `terraform/` directory and use the following commands:

```bash
terraform init
terraform destroy

# type in 'yes' when prompted
```

Note that if you need to use data across sessions, you will need to persist it outside of the infrastructure created, and copy it over to every new instance.

## Backup/Restore
The system also supports backing up and restoring your personal configuration and games. In order to back up your data, you need to navigate to the running instance, find the `foundryuserdata` directory and save all the content to your backup locations. If you include an archive in the `ansible/files/` directory with the name `foundryuserdata.tar.gz`, the ansible script will detect it and extract it to the correct location, allowing you to continue from where you left off.

## Email notifications
The system sets up a cloud watch monitor and sends an email to the configured address if the server is running for longer than 12h, to ensure that the spending on the server is minimal.