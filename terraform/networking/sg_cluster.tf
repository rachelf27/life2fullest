// terraform/networking/sg_cluster.tf

# Create Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_security_group" {
  name   = "eks_cluster_sg"
  vpc_id = aws_vpc.ecom_app_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.eks_all_nodes_security_group.id] # allow all traffic from worker nodes
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks_cluster_sg"
  }
}

output "sg_eks_cluster_id" {
  value = aws_security_group.eks_cluster_security_group.id
}
