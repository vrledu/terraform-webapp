module "vpc" {
  source = "../vpc"
}

#public sg
resource "aws_security_group" "public_security_group_for_ec2" {
  name        = "ec2-public-sg"
  description = "sg for ec2 instance for internet access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#private sg
resource "aws_security_group" "private_security_group_for_ec2" {
  name        = "ec2-private-sg"
  description = "resouces in public sg to have access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 0
    protocol        = "-1"
    to_port         = 0
    security_groups = [aws_security_group.public_security_group_for_ec2.id]
  }

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "heatlh check for instances using this sg"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#elb sg
resource "aws_security_group" "elb_security_group" {
  name        = "elb-sg"
  description = "elb security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow web traffic to elastic load balancer"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "private_launch_configuration_for_app" {
  image_id                    = data.aws_ami.ami_launch_configuration.id
  instance_type               = var.ec2_instance_type
  key_name                    = var.key_pair_name
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.instance_profile_for_ec2.name
  security_groups             = [aws_security_group.private_security_group_for_ec2.id]
  user_data                   = file(var.userdata_for_app)
}

resource "aws_launch_configuration" "public_launch_configuration_for_web" {
  image_id                    = data.aws_ami.ami_launch_configuration.id
  instance_type               = var.ec2_instance_type
  key_name                    = var.key_pair_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance_profile_for_ec2.name
  security_groups             = [aws_security_group.public_security_group_for_ec2.id]
  user_data                   = file(var.userdata_for_web)
}
