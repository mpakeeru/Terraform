variable "aws_region" {
  default = "us-east-2"
}

variable "environment" {
  default = "terraform-dev"
}

variable "amazon-ami" {
    default = "ami-036f5574583e16426"
}

variable "ubuntu-ami" {
    default = "ami-024e6efaf93d85776"
}

variable "centos-ami" {
    default = "ami-011d59a275b482a49"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "CIDR block for Public Subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  default     = ["10.0.16.0/24", "10.0.144.0/24"]
  description = "CIDR block for Private Subnet"
}
