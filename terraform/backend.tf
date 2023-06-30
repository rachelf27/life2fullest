  # terraform/backend.tf
  
  terraform {
    backend "local" {
      path = "terraform.tfstate"
    }
  }
  
