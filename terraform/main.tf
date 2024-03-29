// terraform/main.terraform

module "networking" {
  source = "./networking"
}

module "s3" {
  depends_on = [module.networking]
  source     = "./s3"
}

module "dynamodb" {
  depends_on = [module.networking]
  source     = "./dynamodb"
}

module "elb" {
  source      = "./elb"
  vpc_id      = module.networking.vpc_id
  sg_elb_id   = module.networking.sg_elb_id
  subnet_id_1 = module.networking.subnet_id_1
  subnet_id_2 = module.networking.subnet_id_2
}

module "iam_role_policy" {
  source     = "./iam"
  bucket_arn = module.s3.bucket_arn
}

module "sns" {
  source = "./sns"
}

module "eks" {
  source        = "./eks"
  subnet_id_1   = module.networking.subnet_id_1
  subnet_id_2   = module.networking.subnet_id_2
  alb_dns_name  = module.elb.alb_dns_name
  sg_elb_id     = module.networking.sg_elb_id 
  vpc_id        = module.networking.vpc_id
  iam_role_name = module.iam_role_policy.iam_role_name
  iam_role_arn  = module.iam_role_policy.iam_role_arn
  key_name      = module.networking.key_name
  sg_eks_cluster_id = module.networking.sg_eks_cluster_id
  sg_eks_all_nodes_id   = module.networking.sg_eks_all_nodes_id
}

module "cloudwatch" {
  source        = "./cloudwatch"
  cluster_name  = module.eks.cluster_name
  sns_topic_arn = module.sns.sns_topic_arn
}


