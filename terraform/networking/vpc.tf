// terraform/networking/vpc.tf

# Define the CIDR Block for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Create the VPC
resource "aws_vpc" "ecom_app_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "E-Commerce App VPC"
  }
}

// Output VPC ID
output "vpc_id" {
  value = aws_vpc.ecom_app_vpc.id
}
