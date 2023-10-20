// terraform/networking/sg_nodes.tf

# Create the Security Group for EKS Nodes
resource "aws_security_group" "eks_all_nodes_security_group" {
  name_prefix = "ecom-app-eks-all_nodes-security-group"
  vpc_id      = aws_vpc.ecom_app_vpc.id

  # Set Inbound Rule SSH Access 'from anywhere'
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["50.38.71.252/32"]
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