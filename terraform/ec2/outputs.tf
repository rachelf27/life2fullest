output "ami_id" {
  value = aws_instance.ec2_instance.ami
}

output "instance_type" {
  value = aws_instance.ec2_instance.instance_type
}