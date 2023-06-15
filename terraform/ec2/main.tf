# Create EC2 instance
resource "aws_instance" "ec2_instance" {
  ami        = data.aws_ami.ecom_app_aws_linux_image.id
  count         = var.number_of_instances
  subnet_id     = data.terraform_remote_state.subnets.outputs.subnet_id_1
  instance_type = var.instance_type
  key_name      = var.key_pair_name
}

data "aws_ami" "ecom_app_aws_linux_image" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

data "terraform_remote_state" "subnets" {
  backend = "local"

  config = {
    path = "../networking/terraform.tfstate"
  }
}
