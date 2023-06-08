# Create Public Subnet 1
resource "aws_subnet" "ecom_app_subnet_1" {
  vpc_id = "${aws_vpc.ecom_app_vpc.id}"
  cidr_block = "${var.subnet_1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "E-Commerce App Subnet 1"
  }
}

# Create Public Subnet 2
resource "aws_subnet" "ecom_app_subnet_2" {
  vpc_id = "${aws_vpc.ecom_app_vpc.id}"
  cidr_block = "${var.subnet_2_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {
    Name = "E-Commerce App Subnet 2"
  }
}