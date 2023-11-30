variable "dns_record" {
    type = object({
      name = string
      zone = string
    })
}

resource "gandi_livedns_record" "dns_record" {
    name = var.dns_record.name
    ttl = 300
    type = "A"
    values = [ module.foundry.instance_ip ]
    zone = var.dns_record.zone
}