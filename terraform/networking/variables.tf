# Define CIDR Block for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Define CIDR Block for Subnet 1
variable "subnet_1_cidr" {
  default = "10.0.1.0/24"
}

# Define CIDR Block for Subnet 2
variable "subnet_2_cidr" {
  default = "10.0.2.0/24"
}
