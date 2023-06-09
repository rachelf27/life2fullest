# Create Elastic Load Balancer
resource "aws_lb" "ecom_app_web_lb" {
  name               = "E-Commerce App Web LB"
  security_groups    = [aws_security_group.ecom_app_sg_elb.id]
  subnets            = [
    aws_subnet.ecom_app_subnet_1.id,
    aws_subnet.ecom_app_subnet_2.id
  ]
  enable_cross_zone_load_balancing = true
  idle_timeout                      = 60

  tags = {
    Name = "E-Commerce App Web LB"
  }
}

# Create Target Group
resource "aws_lb_target_group" "ecom_app_web_tg" {
  name        = "E-Commerce App Web TG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ecom_app_vpc.id
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
