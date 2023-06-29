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


  eks_managed_node_groups = {
    load_balancer_ip = var.alb_dns_name
    general = {
      desired_size   = 1
      min_size       = 1
      max_size       = 1
      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
      subnet_ids = [var.subnet_id_1, var.subnet_id_2]
    },
    spot = {
      desired_size   = 1
      min_size       = 1
      max_size       = 10
      instance_types = ["t3.micro"]
      capacity_type  = "SPOT"
      subnet_ids = [var.subnet_id_1, var.subnet_id_2]
    }
  }
}

output "cluster_name" {
  description = "The name of the cluster"
  value       = module.eks.cluster_name
}
