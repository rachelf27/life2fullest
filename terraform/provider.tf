# Create your provider configuration
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1"
    }
  }
}

provider "aws" {
  region          = var.REGION
  access_key      = var.AWS_ACCESS_KEY
  secret_key      = var.AWS_SECRET_KEY
}