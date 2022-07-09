ami = {
  name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server*"
  owner               = "099720109477" # Canonical
  virtualization_type = "hvm"
}

vm_instance = {
  instance_type = "t2.micro"
  public_key    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGkHntfGUk0Nt4n13h2DCN84Yvesq1Vv4yUU7YpP+d0M denis-kralj@users.noreply.github.com"
}

network = {
  address_range = "10.10.10.0/24"
}

# TODO: consider auto generating this
s3_namespace = "dkralj-sandbox"

