output "aws_ami_id" {
  value = data.aws_ami.ami_launch_configuration.id
}
