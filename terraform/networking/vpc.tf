# Create VPC
resource "aws_vpc" "ecom_app_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "E-Commerce App VPC"
  }
}
