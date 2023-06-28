// terraform/outputs.tf

output "product_table_id" {
  value = module.dynamodb.product_table_id
}

output "users_table_id" {
  value = module.dynamodb.users_table_id
}

output "orders_table_id" {
  value = module.dynamodb.orders_table_id
}

output "ami_id" {
  value = module.ec2.ami_id
}

output "instance_type" {
  value = module.ec2.instance_type
}

output "alb_dns_name" {
  value = module.elb.alb_dns_name
}

output "alb_id" {
  value = module.elb.alb_id
}

output "alb_target_grp_arn" {
  value = module.elb.alb_target_grp_arn
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "subnet_id_1" {
  value = module.networking.subnet_id_1
}

output "subnet_id_2" {
  value = module.networking.subnet_id_2
}

output "sg_elb_id" {
  value = module.networking.sg_elb_id
}

output "key_name" {
  value = module.networking.key_name
}

output "bucket_id" {
  value = module.s3.bucket_id
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

output "sns_topic" {
  value = module.sns.sns_topic
}

output "cluster_name" {
  value       = module.eks.cluster_name
}