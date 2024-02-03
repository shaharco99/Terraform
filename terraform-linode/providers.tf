terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.18.0"
    }
  }
}
provider "digitalocean" {
  token = var.tokendig
}
provider "linode" {
  token = var.token
}


#module "setup" {
#  source = "./modules/setup"
#}

variable "tokendig" {
  type = string
}

variable "token" {
  type = string
}