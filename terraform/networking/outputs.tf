output "vpc_id" {
  value = aws_vpc.ecom_app_vpc.id
}

output "subnet_id_1" {
  value = aws_subnet.ecom_app_subnet_1.id
}

output "subnet_id_2" {
  value = aws_subnet.ecom_app_subnet_2.id
}

output "alb_dns_name" {
  value = aws_lb.ecom_app_web_lb.dns_name
}