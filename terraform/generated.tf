variable "license_key" {
  type = string
}

variable "certbot_supplied_email" {
  type = string
}

resource "local_file" "ansible_inventory" {
  content = yamlencode({
    all : {
      hosts : {
        foundry-server : {
          ansible_host : module.foundry.instance_ip
          ansible_connection : "ssh"
          ansible_user : "ubuntu"
          ansible_host_key_checking : false
          ansible_ssh_retries : 10
        }
      },
      vars : {
        foundry_license : var.license_key
        url : local.url
        email : var.certbot_supplied_email
      }
    }
  })

  filename = "../ansible/inventory.yaml"
}