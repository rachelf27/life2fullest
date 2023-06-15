# Create Route Table
resource "aws_route_table" "ecom_app_route" {
  vpc_id = aws_vpc.ecom_app_vpc.id
  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = aws_internet_gateway.ecom_app_gateway.id
  }
  tags = {
    Name = "E-Commerce App Internet Route"
  }
}
# Associate Route Table to Subnet 1
resource "aws_route_table_association" "route_1" {
  subnet_id      = aws_subnet.ecom_app_subnet_1.id
  route_table_id = aws_route_table.ecom_app_route.id
}
# Associate Route Table to Subnet 2
resource "aws_route_table_association" "route_2" {
  subnet_id      = aws_subnet.ecom_app_subnet_2.id
  route_table_id = aws_route_table.ecom_app_route.id
}
