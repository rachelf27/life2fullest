variable "number_of_instances" {
    description = "Total number of instances"
    type = string
    default = "1"
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
