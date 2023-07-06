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

variable "sg_eks_cluster_id" {
  description = "The ID of the EKS Cluster Security Group"
  type        = string
}

variable "sg_eks_all_nodes_id" {
  description = "The ID of the EKS Nodes Security Group"
  type        = string
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~>19.15"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id     = var.vpc_id
  subnet_ids = [var.subnet_id_1, var.subnet_id_2]

  cluster_security_group_id = var.sg_eks_cluster_id

  eks_managed_node_group_defaults = {
    disk_size                     = 10
    min_capacity                  = 1
    max_capacity                  = 2
    desired_capacity              = 1
    capacity_type                 = "SPOT"
    enable_bootstrap_user_data    = true
    user_data_template_path       = "./userData.sh"
    iam_role_name                 = var.iam_role_name
    key_name                      = var.key_name
    additional_security_group_ids = [var.sg_eks_all_nodes_id]
  }

  eks_managed_node_groups = {
    "eks-tf-node" = {
      instance_type = ["t3.small"]
      subnet_ids    = [var.subnet_id_1, var.subnet_id_2]
    }
  }
}

output "cluster_name" {
  description = "The name of the cluster"
  value       = module.eks.cluster_name
}
