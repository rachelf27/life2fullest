# Create Internet Gateway in the VPC created in "vpc.tf"
resource "aws_internet_gateway" "ecom_app_gateway" {
  vpc_id = "${aws_vpc.ecom_app_vpc.id}"
}