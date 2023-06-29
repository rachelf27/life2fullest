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

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~>19.15"

  cluster_name    = "e-com-app-eks-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id = var.vpc_id
  subnet_ids = [var.subnet_id_1, var.subnet_id_2]

  node_groups = {
    general = {
      name = "general"
      instance_type = "t3.small"
      desired_size  = 1
      max_size      = 1
      min_size      = 1
      subnet_ids    = [var.subnet_id_1, var.subnet_id_2]
    },
    spot = {
      name = "spot"
      instance_type = "t3.micro"
      desired_size  = 1
      max_size      = 10
      min_size      = 1
      subnet_ids    = [var.subnet_id_1, var.subnet_id_2]
    }
  }
}

output "cluster_name" {
  description = "The name of the cluster"
  value       = module.eks.cluster_name
}
