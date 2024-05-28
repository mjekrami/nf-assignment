# VPC
variable "vpc_name" {
  type    = string
  default = "nearfield_vpc"
}
variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR Block of the VPC"
}
# Subnets
variable "public_subnet_cidr" {
  type        = string
  default     = "10.0.10.0/24"
  description = "The public subnet"
}
variable "private_subnet_cidr" {
  type        = string
  default     = "10.0.20.0/24"
  description = "The private subnet"
}

variable "public_subnet_name" {
  type    = string
  default = "public_subnet"
}

variable "private_subnet_name" {
  type    = string
  default = "private_subnet"
}
