# Create EC2 instance
resource "aws_instance" "tf_ec2_instance" {
  ami           = "${var.ami_id}"
  count         = "${var.number_of_instances}"
  subnet_id     = "${var.subnet_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_pair}"
}

data "aws_ami" "ecom_app_aws_linux_image" {
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}
