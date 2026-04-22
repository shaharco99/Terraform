variable "platform" {
  description = "The cloud platform to deploy infrastructure on"
  type        = string
  default     = "aws"
  validation {
    condition     = contains(["aws", "azure", "gcp", "linode", "docker"], var.platform)
    error_message = "Platform must be one of: aws, azure, gcp, linode, docker"
  }
}

variable "region" {
  description = "Region for the infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "Instance type/size"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for AWS EC2 (leave empty for auto-detection)"
  type        = string
  default     = ""
}

variable "image_name" {
  description = "Image name for GCP and Azure"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "resource_group_name" {
  description = "Resource group name for Azure"
  type        = string
  default     = "terraform-rg"
}

variable "docker_image" {
  description = "Docker image to use"
  type        = string
  default     = "nginx:latest"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "multi-platform"
  }
}

# Provider-specific variables
variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
  default     = ""
}

variable "azure_client_id" {
  description = "Azure Client ID"
  type        = string
  sensitive   = true
  default     = ""
}

variable "azure_client_secret" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
  default     = ""
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
  default     = ""
}

variable "gcp_credentials_file" {
  description = "Path to GCP credentials JSON file"
  type        = string
  default     = ""
}

variable "linode_token" {
  description = "Linode API token"
  type        = string
  sensitive   = true
  default     = ""
}

variable "authorized_key" {
  description = "SSH public key for instances"
  type        = string
  default     = ""
}

variable "root_pass" {
  description = "Root password for Linode instances"
  type        = string
  sensitive   = true
  default     = ""
}