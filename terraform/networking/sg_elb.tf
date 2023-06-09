# Create Security Group for ELB
resource "aws_security_group" "ecom_app_sg_elb" {
  name        = "E-Commerce Security Group for ELB"
  description = "Module for ELB"
  vpc_id      = aws_vpc.ecom_app_vpc.id

  # Set Inbound Rule for HTTP Access 'from anywhere'
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Set Inbound Rule for HTTPS Access 'from anywhere'
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Set Inbound Rule for SSH Access 'from anywhere'
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Set Outbound Rules for Internet Access 'to anywhere'
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
