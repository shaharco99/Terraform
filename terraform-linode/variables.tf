variable "token" {
  description = "Linode API token"
  type        = string
  sensitive   = true
}

variable "tokendig" {
  description = "DigitalOcean API token (DNS records)"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Linode region, e.g. eu-central"
  type        = string
}

variable "instance_count" {
  description = "Number of Linode instances"
  type        = number
  default     = 1
}

variable "label_prefix" {
  description = "Instance labels are <label_prefix>-<n>; also used as DNS record names"
  type        = string
}

variable "image" {
  description = "Linode image"
  type        = string
  default     = "linode/ubuntu20.04"
}

variable "instance_type" {
  description = "Linode plan"
  type        = string
  default     = "g6-nanode-1"
}

variable "authorized_key" {
  description = "SSH public key for root"
  type        = string
}

variable "root_pass" {
  description = "Root password"
  type        = string
  sensitive   = true
}

variable "dns_domain" {
  description = "Domain managed in DigitalOcean DNS"
  type        = string
}
