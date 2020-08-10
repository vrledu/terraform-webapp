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

variable "ec2_instance_type" {
  default     = "t2.micro"
  description = "ec2 instance type"
}

variable "key_pair_name" {
  default     = "vijay_keypair"
  description = "keypair to connect to ec2"
}

variable "userdata_for_app" {
  default     = "../../app/appserver.sh"
  description = "app server userdata"
}

variable "userdata_for_web" {
  default     = "../../app/webserver.sh"
  description = "web server userdata"
}

variable "max_instance_size" {
  default     = 5
  description = "maximum number of instances to launch"
}

variable "min_instance_size" {
  default     = 3
  description = "minimum number of instances to launch"
}

variable "sns_subscription_email_address_list" {
  type        = list(string)
  default     = ["vijayaraghavan.lakshman@gmail.com"]
  description = "List of email addresses"
}

variable "sns_subscription_protocol" {
  type        = string
  default     = "email"
  description = "SNS subscription protocol"
}

variable "sns_topic_name" {
  type        = string
  default     = "ec2_healthy_count"
  description = "ec2_healthy"
}

variable "sns_topic_display_name" {
  type        = string
  default     = "ec2_healthy_alert"
  description = "ec2_healthy"
}

data "aws_availability_zones" "azs" {}
