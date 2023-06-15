output "vpc_id" {
  value = aws_vpc.ecom_app_vpc.id
}

output "subnet_id_1" {
  value = aws_subnet.ecom_app_subnet_1.id
}

output "subnet_id_2" {
  value = aws_subnet.ecom_app_subnet_2.id
}

output "sg_elb_id" {
  value = aws_security_group.ecom_app_sg_elb.id
}

output "key_name" {
  value = aws_key_pair.ecom_app_key_pair.key_name
}
