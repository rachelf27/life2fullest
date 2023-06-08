# Create Launch Configuration
resource "aws_launch_configuration" "ecom_app_web_lconfig" {
  name_prefix                 = "web-"
  image_id                    = ""
  instance_type               = ""
  key_name                    = ""
  security_groups             = ["${aws_security_group.aws_security_group.ecom_app_sg_elb.id}"]
  associate_public_ip_address = true
  user_data                   = file("data.sh")
  lifecycle {
    create_before_destroy = true
  }
}