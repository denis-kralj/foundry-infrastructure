# configures terraform for aws use on specific region with specific profile
terraform {
  required_providers {
    gandi = {
      version = "~> 2.0.0"
      source   = "go-gandi/gandi"
    }
  }
  required_version = "~> 1.1"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

provider "gandi" {
}