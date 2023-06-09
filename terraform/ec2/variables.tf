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
    path = "../terraform/networking/terraform.tfstate"
  }
}

variable "ami_id" {
  description = "The AMI Id"
  type        = string
  default     = data.aws_ami.ecom_app_aws_linux_image.id
}

variable "number_of_instances" {
    description = "Total number of instances"
    type = string
    default = "1"
}

variable "subnet_id" {
    description = "The subnet to use"
    type = string
    default = data.terraform_remote_state.subnets.outputs.subnet_id_1
}

variable "instance_type" {
    description = "Type of instance"
    type = string
    default = "t2.micro"
}

variable "key_pair_name" {
  description = "The Key Pair name"
  type        = string
  default     = "ecom_app_key"
}
