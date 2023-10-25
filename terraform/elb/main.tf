// terraform/elb/main.tf

variable "sg_elb_id" {
  description = "Security Group Id for ELB"
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

# Create Application Load Balancer
resource "aws_lb" "ecom_app_web_lb" {
  name            = "e-commerce-app-web-lb"
  security_groups = [var.sg_elb_id]
  subnets = [
    var.subnet_id_1,
    var.subnet_id_2
  ]
  enable_cross_zone_load_balancing = true
  idle_timeout                     = 60

  tags = {
    Name = "E-Commerce App Web LB"
  }
}

# Create Target Group
resource "aws_lb_target_group" "ecom_app_web_tg_frontend" {
  name        = "e-commerce-app-eb-tg-frontend"
  port        = 31000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
   port = 31000
  }
}

# Create Target Group
resource "aws_lb_target_group" "ecom_app_web_tg_backend" {
  name        = "e-commerce-app-eb-tg-backend"
  port        = 32000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
   port = 32000
  }
}

# Create Listener
resource "aws_lb_listener" "ecom_app_web_listener_frontend" {
  load_balancer_arn = aws_lb.ecom_app_web_lb.arn
  port              = 80
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecom_app_web_tg_frontend.arn
  }
}

resource "aws_lb_listener" "ecom_app_web_listener_backend" {
  load_balancer_arn = aws_lb.ecom_app_web_lb.arn
  port              = 8080
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecom_app_web_tg_frontend.arn
  }
}

output "alb_dns_name" {
  value = aws_lb.ecom_app_web_lb.dns_name
}

output "alb_id" {
  value = aws_lb.ecom_app_web_lb.id
}

output "alb_target_grp_frontend_arn" {
  value = aws_lb_target_group.ecom_app_web_tg_frontend.arn
}

output "alb_target_grp_backend_arn" {
  value = aws_lb_target_group.ecom_app_web_tg_backend.arn
}
