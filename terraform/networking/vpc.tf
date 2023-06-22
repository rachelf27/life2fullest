# Define CIDR Block for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Create VPC
resource "aws_vpc" "ecom_app_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "E-Commerce App VPC"
  }
}
