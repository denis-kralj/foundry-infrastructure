# FoundryVTT on AWS + Gandi DNS record

## Software Requirements

- [Terraform](https://www.terraform.io/)
- [Ansible](https://www.ansible.com/)

## Service requirements

- [AWS account](https://aws.amazon.com/)
- [gandi.net account](https://www.gandi.net/en)

## Prerequisites

1. The solution assumes that an AWS account named 'default' is configured on the local machine and has the proper rights to create the required resources.
2. An example configuration file named `terraform.auto.tfvars.example` contains all variables required for the infrastructure.
3. Ansible requires a zip archive `foundry.zip` with the foundry release binary (this can be downloaded from the [FoundryVTT website](https://foundryvtt.com/) in the 'Purchased Software Licenses' page).

This solution was tested with Foundry VTT v11 and is not guaranteed to work with other versions.

## Use

This repository allows the user to spin up infrastructure in order to host a private instance of FoundryVTT. The infrastructure created is free tier eligible.

Two scripts were provided for convenience, use them to bring the server up and down as needed:

```shell
# use this to bring up the server and set it up
./spin-up.sh

# use this to shut down the server once it is no longer needed
./tear-down.sh
```

Note that these scripts assume all of the listed prerequisites above have been fulfilled.

### Detailed spin up and teardown steps
Navigate to the `terraform/` directory and use the following commands:

```bash
terraform init
terraform apply

# input all variables requested and type in 'yes' when prompted
```

The script generates an inventory file in the `ansible/` directory that should be used in the next step.

Navigate to the `ansible/` directory and use the following command:

```bash
# this command expects foundry.zip to be present (see prerequisites)
ansible-playbook -i inventory.yaml playbook.yaml
```

At the end of execution the command will give you an address to navigate to. From there setup the foundry instance as usual.

When done, you can delete the infrastructure by simply destroying resources via terraform. Navigate to the `terraform/` directory and use the following commands:

```bash
terraform init
terraform destroy

# you can set all variables to empty and type in 'yes' when prompted
```

Note that if you need to use data across sessions, you will need to persist it outside of the infrastructure created, and copy it over to every new instance. __*If you don't do this you will loose user data stored on the server*__

## Backup/Restore
The system also supports backing up and restoring your personal configuration and games. In order to back up your data, you need to navigate to the running instance, find the `foundryuserdata` directory and save all the content to your backup locations. If you include an archive in the `ansible/files/` directory with the name `foundryuserdata.tar.gz`, the ansible script will detect it and extract it to the correct location, allowing you to continue from where you left off.

## Email notifications
The system sets up a cloud watch monitor and sends an email to the configured address if the server is running for longer than 12h, to ensure that the spending on the server is minimal.