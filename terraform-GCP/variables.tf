variable "credentials" {
  description = "Path to a service account JSON key (kept outside the repo)"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region, e.g. asia-east1"
  type        = string
}

variable "zone" {
  description = "GCP zone for the instances"
  type        = string
  default     = "asia-east1-a"
}

variable "machine_type" {
  description = "Machine type, e.g. e2-micro"
  type        = string
}

variable "image_name" {
  description = "Boot image, e.g. ubuntu-os-cloud/ubuntu-2204-lts"
  type        = string
}

variable "amount_of_instance" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}
