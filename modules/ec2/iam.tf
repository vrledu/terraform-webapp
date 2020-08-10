#ec2 iam role
resource "aws_iam_role" "iam_role_for_ec2" {
  name               = "iam-role-ec2"
  assume_role_policy = file("./templates/ec2_assume_role.json")
}

#ec2 iam policy
resource "aws_iam_role_policy" "iam_role_policy_for_ec2" {
  name   = "ec2-iam-policy"
  role   = aws_iam_role.iam_role_for_ec2.id
  policy = file("./templates/ec2_policy.json")
}

#ec2 instance profile
resource "aws_iam_instance_profile" "instance_profile_for_ec2" {
  name = "ec2-iam-instance-profile"
  role = aws_iam_role.iam_role_for_ec2.name
}

#ami for ec2
data "aws_ami" "ami_launch_configuration" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}
