resource "aws_instance" "foundry-server" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
}

# TODO: need a security group to expose SSH, HTTP, maybe HTTPS
resource "aws_security_group" "foundry-access-sg" {
  
}

# TODO: S3 bucket with required access rights
# TODO: user to be able to access the S3 bucket
# TODO: user that can start and stop the EC2 instance at will

# TODO: probably some networking details, not sure