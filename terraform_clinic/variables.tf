variable "region" {
  default = "eu-central-1"
}

variable "cluster_name" {
  default = "my-ecs-cluster"
}

variable "vpc_id" {
  default = "vpc-12345678"
}

variable "public_subnet_ids" {
  default = ["subnet-12345678", "subnet-87654321"]
}

variable "s3_bucket_name" {
  default = "my-s3-bucket"
}

variable "route53_zone_name" {
  default = "example.com."
}

variable "route53_record_name" {
  default = "/api"
}

variable "health_check_path" {
  default = "/health"
}


variable "target_group_name" {
  default = "my-ecs-target-group"
}

variable "load_balancer_name" {
  default = "my-ecs-load-balancer"
}

variable "load_balancer_arn" {
  default = ""
}

variable "dns_name" {
  default = ""
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}
