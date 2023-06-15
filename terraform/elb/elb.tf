data "terraform_remote_state" "ec2_outputs" {
  backend = "local"

  config = {
    path = "../ec2/terraform.tfstate"
  }
}

data "terraform_remote_state" "networking_outputs" {
  backend = "local"

  config = {
    path = "../networking/terraform.tfstate"
  }
}

# Create Application Load Balancer
resource "aws_lb" "ecom_app_web_lb" {
  name               = "e-commerce-app-web-lb"
  security_groups    = [ data.terraform_remote_state.networking_outputs.outputs.sg_elb_id]
  subnets            = [
    data.terraform_remote_state.networking_outputs.outputs.subnet_id_1,
    data.terraform_remote_state.networking_outputs.outputs.subnet_id_2
  ]
  enable_cross_zone_load_balancing = true
  idle_timeout                      = 60

  tags = {
    Name = "E-Commerce App Web LB"
  }
}

# Create Target Group
resource "aws_lb_target_group" "ecom_app_web_tg" {
  name        = "e-commerce-app-eb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.networking_outputs.outputs.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}

# Create Listener
resource "aws_lb_listener" "ecom_app_web_listener" {
  load_balancer_arn = aws_lb.ecom_app_web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecom_app_web_tg.arn
  }
}
