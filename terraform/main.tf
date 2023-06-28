// terraform/main.terraform

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
  sg_elb_id   = module.elb.sg_elb_id
  subnet_id_1 = module.networking.subnet_id_1
  subnet_id_2 = module.networking.subnet_id_2
}

module "s3" {
  depends_on = [module.networking]
  source     = "./s3"
}

module "networking" {
  source = "./networking"
}

module "eks_cluster" {
  source       = "./eks_cluster.tf"
  subnet_id_1  = module.networking.subnet_id_1
  subnet_id_2  = module.networking.subnet_id_2
  alb_dns_name = module.elb.alb_dns_name
  vpc_id       = module.networking.vpc_id
}

module "cloudwatch" {
  source      = "./cloudwatch.tf"
  instance_id = module.ec2.ami_id
}

module "iam_role_policy" {
  source     = "./iam_role_policy.tf"
  bucket_arn = module.s3.bucket_arn
}
