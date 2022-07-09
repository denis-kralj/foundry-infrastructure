# depends on main.tf

variable "ami" {
  type = object({
    name                = string
    owner               = string
    virtualization_type = string
  })
}

variable "vm_instance" {
  type = object({
    instance_type = string
    public_key    = string
  })
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami.name]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ami.virtualization_type]
  }

  owners = [var.ami.owner]
}

resource "aws_key_pair" "admin" {
  key_name   = "admin-key"
  public_key = var.vm_instance.public_key
  tags       = local.tags
}

resource "aws_network_interface" "foundry" {
  subnet_id       = aws_subnet.foundry.id
  security_groups = [aws_vpc.main.default_security_group_id]

  tags = local.tags
}

resource "aws_eip" "foundry" {
  vpc               = true
  network_interface = aws_network_interface.foundry.id
  public_ipv4_pool  = "amazon"
  tags              = local.tags
}

resource "aws_instance" "foundry-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.vm_instance.instance_type
  key_name      = aws_key_pair.admin.key_name

  network_interface {
    network_interface_id = aws_network_interface.foundry.id
    device_index         = 0
  }

  tags = local.tags
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface

# https://docs.aws.amazon.com/cli/latest/reference/ec2/allocate-address.html#examples
