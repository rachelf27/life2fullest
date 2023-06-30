// terraform/eks_cluster.tf 

variable "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  type        = string
}

variable "subnet_id_1" {
  description = "Subnet Id 1"
  type        = string
}

variable "subnet_id_2" {
  description = "Subnet Id 2"
  type        = string
}

variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "key_name" {
  description = "Name of Key Pair"
  type        = string
}

variable "iam_role_arn" {
  description = "The ARN of the IAM Role for EKS worker Nodes"
  type        = string
}

variable "iam_role_name" {
  description = "The name of the IAM Role for EKS worker Nodes"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS Cluster"
  default     = "e-com-app-eks-cluster"
  type        = string
}

resource "aws_security_group" "eks_worker_security_group" {
  name_prefix = "ecom-app-eks-worker-security-group"
  vpc_id      = var.vpc_id

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
    Name = "ecom_app_sg_eks_nodes"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~>19.15"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id     = var.vpc_id
  subnet_ids = [var.subnet_id_1, var.subnet_id_2]

  #worker_create_security_group = true

  eks_managed_node_group_defaults = {
    disk_size                     = 10
    min_capacity                  = 1
    max_capacity                  = 2
    desired_capacity              = 1
    capacity_type                 = "SPOT"
    enable_bootstrap_user_data    = true
    user_data_template_path       = "./userData.sh"
    iam_role_name                 = var.iam_role_arn
    key_name                      = var.key_name
    additional_security_group_ids = [aws_security_group.eks_worker_security_group.id]
  }

  eks_managed_node_groups = {
    "spot-small" = {
      instance_type = ["t3.small"]
      subnet_ids    = [var.subnet_id_1, var.subnet_id_2]
    }
    "spot-micro" = {
      instance_type = ["t3.micro"]
      subnet_ids    = [var.subnet_id_1, var.subnet_id_2]
    }
  }
}

data "aws_eks_cluster" "kube_cluster" {
  name = var.cluster_name
  depends_on = [module.eks]
}


data "aws_eks_cluster_auth" "kube_cluster_auth" {
  name = var.cluster_name
  depends_on = [module.eks]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.kube_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.kube_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.kube_cluster_auth.token
}

output "cluster_name" {
  description = "The name of the cluster"
  value       = module.eks.cluster_name
}
