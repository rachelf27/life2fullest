// terraform/networking/igw.tf

// Create an Internet Gateway within the VPC from "vpc.tf"
resource "aws_internet_gateway" "ecom_app_gateway" {
  vpc_id = aws_vpc.ecom_app_vpc.id

  tags = {
    Name = "E-Commerce App IGW"
  }
}
