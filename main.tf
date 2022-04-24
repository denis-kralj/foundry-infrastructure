variable "application" {
  type    = string
  default = "foundry"
}

variable "network" {
  type = object({
    address_range = string
  })
}

locals {
  tags = {
    Name = var.application
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.network.address_range
  tags       = local.tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = local.tags
}

resource "aws_subnet" "foundry" {
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.network.address_range, 2, 0)
  tags = local.tags
}

# TODO: need a security group to expose SSH, HTTP, maybe HTTPS
resource "aws_security_group" "foundry" {
  name        = "allow_foundry"
  description = "Allow rules for the foundry HTTP server"
  vpc_id      = aws_vpc.main.id
  tags        = local.tags

  ingress {
    description      = "SSH from the internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP from the internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS from the internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# TODO: S3 bucket with required access rights
# TODO: user to be able to access the S3 bucket
# TODO: user that can start and stop the EC2 instance at will

# TODO: probably some networking details, not sure


# 255 255 0-255 0-255
# "10.0.0.0/16"
# 10.0.0.0
# 10.0.255.255

# 10.32.10.20/32
# 0.0.0.0/0
# https://en.wikipedia.org/wiki/Reserved_IP_addresses

# 10.0.0.0/8
# 10.0.0.0
# 10.255.255.255

# 100.64.0.0/10	

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

# https://www.terraform.io/language/functions/cidrsubnet