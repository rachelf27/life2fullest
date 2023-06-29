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

module "ec2" {
  source      = "./ec2"
  subnet_id_1 = module.networking.subnet_id_1
}

module "elb" {
  source      = "./elb"
  vpc_id       = module.networking.vpc_id
  sg_elb_id   = module.networking.sg_elb_id
  subnet_id_1 = module.networking.subnet_id_1
  subnet_id_2 = module.networking.subnet_id_2
}

module "iam_role_policy" {
  source     = "./iam"
  bucket_arn = module.s3.bucket_arn
}

module "sns" {
  source      = "./sns"
}

module "eks" {
  source       = "./eks"
  subnet_id_1  = module.networking.subnet_id_1
  subnet_id_2  = module.networking.subnet_id_2
  alb_dns_name = module.elb.alb_dns_name
  vpc_id       = module.networking.vpc_id
  iam_role_name = module.iam_role_policy.iam_role_name
}

module "cloudwatch" {
  source      = "./cloudwatch"
  cluster_name = module.eks.cluster_name
  sns_topic_arn = module.sns.sns_topic_arn
}


