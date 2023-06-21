# Create your provider configuration
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      region                   = "us-east-1"
      access_key      = var.AWS_ACCESS_KEY
      secret_key      = var.AWS_SECRET_KEY
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1"
    }
  }
}