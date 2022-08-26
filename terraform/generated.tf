resource "local_file" "foo" {
    content  = "foundry-server ansible_host=${module.foundry.instance_ip} ansible_connection=ssh ansible_user=ubuntu ansible_host_key_checking=False"
    filename = "../ansible/inventory.ini"
}