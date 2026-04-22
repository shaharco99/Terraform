terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    linode = {
      source  = "linode/linode"
      version = "~> 1.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.platform == "aws" && var.aws_access_key != "" ? var.aws_access_key : null
  secret_key = var.platform == "aws" && var.aws_secret_key != "" ? var.aws_secret_key : null
}

provider "azurerm" {
  subscription_id = var.platform == "azure" && var.azure_subscription_id != "" ? var.azure_subscription_id : null
  client_id       = var.platform == "azure" && var.azure_client_id != "" ? var.azure_client_id : null
  client_secret   = var.platform == "azure" && var.azure_client_secret != "" ? var.azure_client_secret : null
  tenant_id       = var.platform == "azure" && var.azure_tenant_id != "" ? var.azure_tenant_id : null
  features {}
}

provider "google" {
  credentials = var.platform == "gcp" && var.gcp_credentials_file != "" ? file(var.gcp_credentials_file) : null
  region      = var.region
  zone        = "${var.region}-a"
}

provider "linode" {
  token = var.platform == "linode" && var.linode_token != "" ? var.linode_token : null
}

provider "docker" {}
