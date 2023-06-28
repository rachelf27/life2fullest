// terraform/networking/subnet.tf

# Define CIDR Block for Subnet 1
variable "subnet_1_cidr" {
  default = "10.0.1.0/24"
}

# Define CIDR Block for Subnet 2
variable "subnet_2_cidr" {
  default = "10.0.2.0/24"
}

# Create Public Subnet 1
resource "aws_subnet" "ecom_app_subnet_1" {
  vpc_id                  = aws_vpc.ecom_app_vpc.id
  cidr_block              = var.subnet_1_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "E-Commerce App Subnet 1"
  }
}

# Create Public Subnet 2
resource "aws_subnet" "ecom_app_subnet_2" {
  vpc_id                  = aws_vpc.ecom_app_vpc.id
  cidr_block              = var.subnet_2_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "E-Commerce App Subnet 2"
  }
}

output "subnet_id_1" {
  value = aws_subnet.ecom_app_subnet_1.id
}

output "subnet_id_2" {
  value = aws_subnet.ecom_app_subnet_2.id
}
