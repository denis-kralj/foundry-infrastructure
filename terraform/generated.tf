variable "license_key" {
  type = string
}

variable "certbot_supplied_email" {
  type = string
}

resource "local_file" "ansible_inventory" {
    content  = <<EOT
all:
  hosts:
    foundry-server:
      ansible_host: ${module.foundry.instance_ip}
      ansible_connection: ssh
      ansible_user: ubuntu
      ansible_host_key_checking: False
      ansible_ssh_retries: 10
  vars:
    foundry_license: ${var.license_key}
    url: ${local.url}
    email: ${var.certbot_supplied_email}

EOT
    filename = "../ansible/inventory.yaml"
}