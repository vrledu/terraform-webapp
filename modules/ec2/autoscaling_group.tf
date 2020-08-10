#asg for private
resource "aws_autoscaling_group" "private_autoscaling_group" {
  name = "appserver-autoscaling-group"
  vpc_zone_identifier = [
    module.vpc.private_subnet_1,
    module.vpc.private_subnet_2,
    module.vpc.private_subnet_3
  ]
  max_size             = var.max_instance_size
  min_size             = var.min_instance_size
  launch_configuration = aws_launch_configuration.private_launch_configuration_for_app.name
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.app_load_balancer.name]

  tag {
    key                 = "name"
    propagate_at_launch = false
    value               = "appserver-ec2"
  }
}

#asg for public
resource "aws_autoscaling_group" "public_autoscaling_group" {
  name = "webserver-autoscaling-group"
  vpc_zone_identifier = [
    module.vpc.public_subnet_1,
    module.vpc.public_subnet_2,
    module.vpc.public_subnet_3
  ]
  max_size             = var.max_instance_size
  min_size             = var.min_instance_size
  launch_configuration = aws_launch_configuration.public_launch_configuration_for_web.name
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.web_load_balancer.name]

  tag {
    key                 = "name"
    propagate_at_launch = false
    value               = "webserver-ec2"
  }
}

#asg policy for webserver
resource "aws_autoscaling_policy" "webserver_scaling_policy" {
  autoscaling_group_name   = aws_autoscaling_group.public_autoscaling_group.name
  name                     = "webserver-autoscaling-policy"
  policy_type              = "TargetTrackingScaling"
  min_adjustment_magnitude = 1

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}

#asg policy for appserver
resource "aws_autoscaling_policy" "appserver_scaling_policy" {
  autoscaling_group_name   = aws_autoscaling_group.private_autoscaling_group.name
  name                     = "appserver-autoscaling-policy"
  policy_type              = "TargetTrackingScaling"
  min_adjustment_magnitude = 1

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}
