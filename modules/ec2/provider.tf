#provider
provider "aws" {
  region = var.region
}

#terraform remote state
terraform {
  backend "s3" {}
}

data "terraform_remote_state" "instance" {
  backend = "s3"
  config = {
    region = "${var.region}"
    bucket = "${var.remote_state_bucket}"
    key    = "${var.remote_state_key}"
  }
}
