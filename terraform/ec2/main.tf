// terraform/ec2/main.terraform 

variable "number_of_instances" {
  description = "Total number of instances"
  type        = string
  default     = "1"
}

variable "instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "The Key Pair name"
  type        = string
  default     = "ecom_app_key"
}

# Create EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.ecom_app_aws_linux_image.id
  count         = var.number_of_instances
  subnet_id     = var.subnet_id_1
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

output "ami_id" {
  description = "The id of the created ami"
  value       = aws_instance.ec2_instance.ami
}
