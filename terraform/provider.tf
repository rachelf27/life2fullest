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
  region                   = "us-east-1"
  //access_key      = var.AWS_ACCESS_KEY
  //secret_key      = var.AWS_SECRET_KEY
  // shared_credentials_files = ["../../../../../rachelmurphy/.aws/credentials"]
  //shared_credentials_files = [""]

}
