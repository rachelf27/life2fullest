output "alb_dns_name" {
  value = aws_lb.ecom_app_web_lb.dns_name
}

output "alb_id" {
  value = aws_lb.ecom_app_web_lb.id
}

 output "alb_target_grp_arn" {
   value = aws_lb_target_group.ecom_app_web_tg.arn
 }