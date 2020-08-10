variable "region" {
  default     = "eu-west-2"
  description = "london region"
}

variable "remote_state_bucket" {
  default     = "vijay-terraform-remote-state-2020-08"
  description = "bucket name for remote state"
}

variable "remote_state_key" {
  default     = "terraform/web_app_infra.tfstate"
  description = "key name for remote state"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
}

variable "vpc_tenancy" {
  default     = "default"
  description = "vpc tenancy"
}

variable "public_subnet_1_cidr" {
  default     = "10.0.1.0/24"
  description = "public subnet 1 cidr"
}

variable "public_subnet_2_cidr" {
  default     = "10.0.2.0/24"
  description = "public subnet 2 cidr"
}

variable "public_subnet_3_cidr" {
  default     = "10.0.3.0/24"
  description = "public subnet 3 cidr"
}

variable "private_subnet_1_cidr" {
  default     = "10.0.4.0/24"
  description = "private subnet 1 cidr"
}

variable "private_subnet_2_cidr" {
  default     = "10.0.5.0/24"
  description = "private subnet 2 cidr"
}

variable "private_subnet_3_cidr" {
  default     = "10.0.6.0/24"
  description = "private subnet 3 cidr"
}

variable "nat_gateway_private_ip" {
  default = "10.0.0.7"
}

data "aws_availability_zones" "azs" {}
