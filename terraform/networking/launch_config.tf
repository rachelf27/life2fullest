data "terraform_remote_state" "ec2_outputs" {
  backend = "local"
  config = {
    path = "../terraform/ec2/terraform.tfstate"
  }
}

resource "aws_launch_configuration" "ecom_app_web_lconfig" {
  name_prefix                 = "web-lc"
  image_id                    = data.terraform_remote_state.ec2_outputs.outputs.ami_id
  instance_type               = data.terraform_remote_state.ec2_outputs.outputs.instance_type
  key_name                    = aws_key_pair.ecom_app_key_pair.key_name
  security_groups             = [aws_security_group.aws_security_group.ecom_app_sg_elb.id]
  associate_public_ip_address = true
  user_data                   = file("../userData.sh")
  lifecycle {
    create_before_destroy = true
  }
}
