// terraform/networking/sg_cluster.tf

# Create Security Group for EKS Nodes
resource "aws_security_group" "eks_all_nodes_security_group" {
  name_prefix = "ecom-app-eks-all_nodes-security-group"
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
    Name = "ecom_app_all_nodes_sg"
  }
}

output "sg_eks_all_nodes_id" {
  value = aws_security_group.eks_all_nodes_security_group.id
}