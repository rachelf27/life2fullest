variable "ami_id" {
  description = "The AMI Id"
  type        = string
  default     = ""
}

variable "number_of_instances" {
    description = "Total number of instances"
    type = string
    default = "1"
}

variable "subnet_id" {
    description = "The subnet to use"
    type = string
    default = "value"
}

variable "instance_type" {
    description = "Type of instance"
    type = string
    default = "t2.micro"
}

variable "key_pair" {
  description = "value"
  type = string
  default = "value"
}