variable "application" {
  type    = string
  default = "foundry"
}

locals {
  tags = {
    Name = var.application
  }
  url = "${var.dns_record.name}.${var.dns_record.zone}"
}
