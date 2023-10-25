// terraform/networking/sg_cluster.tf

# Create the Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster_security_group" {
  name   = "eks_cluster_sg"
  vpc_id = aws_vpc.ecom_app_vpc.id

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

resource "aws_security_group_rule" "allow_all_from_nodes_to_cluster" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.eks_all_nodes_security_group.id
  security_group_id        = aws_security_group.eks_cluster_security_group.id

  depends_on = [
    aws_security_group.eks_all_nodes_security_group,
    aws_security_group.eks_cluster_security_group
  ]
}

output "sg_eks_cluster_id" {
  value = aws_security_group.eks_cluster_security_group.id
}
