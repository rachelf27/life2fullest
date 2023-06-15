# Create Security Group for EC2
resource "aws_security_group" "ecom_app_sg_ec2" {
  name        = "e-commerce-app-sg-ec2"
  description = "Module for EC2"
  vpc_id      = aws_vpc.ecom_app_vpc.id

  # Set Inbound Rule for HTTP Access 'from anywhere'
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Set Inbound Rule HTTPS Access 'from anywhere'
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Set Inbound Rule SSH Access 'from anywhere'
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Set Outbound Rules Internet Access 'to anywhere'
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "ecom_app_sg_ec2"
  }
}
