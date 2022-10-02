variable "application" {
  type    = string
  default = "foundry"
}

locals {
  tags = {
    Name = var.application
  }
}
