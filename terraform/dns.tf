variable "dns-record" {
    type = object({
      name = string
      zone = string
    })
}

resource "gandi_livedns_record" "dns-record" {
    name = var.dns-record.name
    ttl = 300
    type = "A"
    values = [ module.foundry.instance_ip ]
    zone = var.dns-record.zone
}