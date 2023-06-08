# Create Elastic Load Balancer
resource "aws_elb" "ecom_app_web_elb" {
  name            = "E-Commerce App Web ELB"
  security_groups = ["${aws_security_group.ecom_app_sg_elb}"]
  subnets = [
    "${aws_subnet.ecom_app_subnet_1}",
    "${aws_subnet.ecom_app_subnet_2}"
  ]
  cross_zone_load_balancing = true
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}
