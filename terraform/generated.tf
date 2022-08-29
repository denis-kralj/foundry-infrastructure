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
EOT
    filename = "../ansible/inventory.yaml"
}