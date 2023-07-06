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
  value = module.sns.sns_topic_arn
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "iam_role_arn" {
  value = module.iam_role_policy.iam_role_arn
}

output "iam_role_name" {
  value = module.iam_role_policy.iam_role_name
}

output "route_table_id" {
  value = module.networking.route_table_id
}

output "sg_eks_all_nodes_id" {
  value = module.networking.sg_eks_all_nodes_id
}

output "sg_eks_cluster_id" {
  value = module.networking.sg_eks_cluster_id
}
