data "terraform_remote_state" "networking" {
   backend = "local"

  config = {
    path = "../networking/terraform.tfstate"
  }
}

data "terraform_remote_state" "_elb_alb_dns_name" {
  backend = "local"

  config = {
    path = "../elb/terraform.tfstate"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~>19.15"

  cluster_name    = "e-com-app-eks-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id = data.terraform_remote_state.networking.outputs.vpc_id

  eks_managed_node_groups = {
    load_balancer_ip = data.terraform_remote_state._elb_alb_dns_name.outputs.alb_dns_name
    general = {
      desired_size    = 1
      min_size        = 1
      max_size        = 1
      instance_types  = ["t3.small"]
      capacity_type   = "ON_DEMAND"
      subnet_ids      = [
        data.terraform_remote_state.networking.outputs.subnet_id_1,
        data.terraform_remote_state.networking.outputs.subnet_id_2
      ]
    }

    spot = {
      desired_size    = 1
      min_size        = 1
      max_size        = 10
      instance_types  = ["t3.micro"]
      capacity_type   = "SPOT"
      subnet_ids      = [
        data.terraform_remote_state.networking.outputs.subnet_id_1,
        data.terraform_remote_state.networking.outputs.subnet_id_2
      ]
    }
  }
}
