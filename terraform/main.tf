variable "application" {
  type    = string
  default = "foundry"
}

locals {
  tags = {
    Name = var.application
  }
  url = "${var.dns-record.name}.${var.dns-record.zone}"
}
