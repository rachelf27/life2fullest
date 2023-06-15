data "terraform_remote_state" "ec2_outputs" {
  backend = "local"

  config = {
    path = "../ec2/terraform.tfstate"
  }
}

data "terraform_remote_state" "networking_outputs_2" {
  backend = "local"

  config = {
    path = "../networking/terraform.tfstate"
  }
}

resource "aws_launch_configuration" "ecom_app_web_lconfig" {
  name_prefix                 = "web-lc"
  image_id                    = data.terraform_remote_state.ec2_outputs.outputs.ami_id[0]
  instance_type               = data.terraform_remote_state.ec2_outputs.outputs.instance_type[0]
  key_name                    = data.terraform_remote_state.networking_outputs_2.outputs.key_name
  security_groups             = [data.terraform_remote_state.networking_outputs_2.outputs.sg_elb_id]
  associate_public_ip_address = true
  user_data                   = file("../userData.sh")
  lifecycle {
    create_before_destroy = true
  }
}
