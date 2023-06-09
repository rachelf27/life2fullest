# Create EC2 instance
resource "aws_instance" "ec2_instance" {
  ami_id        = var.ami_id
  count         = var.number_of_instances
  subnet_id     = var.subnet_id
  instance_type = var.instance_type
  key_name      = var.key_pair
}
