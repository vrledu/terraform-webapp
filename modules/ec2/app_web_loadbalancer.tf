#load balancer for webserver
resource "aws_elb" "web_load_balancer" {
  name            = "webserver-loadbalancer"
  internal        = false
  security_groups = [aws_security_group.elb_security_group.id]
  subnets = [
    module.vpc.public_subnet_1,
    module.vpc.public_subnet_2,
    module.vpc.public_subnet_3
  ]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    healthy_threshold   = 5
    interval            = 30
    target              = "HTTP:80/index.html"
    timeout             = 10
    unhealthy_threshold = 5
  }
}

#load balancer for app server
resource "aws_elb" "app_load_balancer" {
  name            = "appserver-loadbalancer"
  internal        = true
  security_groups = [aws_security_group.elb_security_group.id]
  subnets = [
    module.vpc.private_subnet_1,
    module.vpc.private_subnet_2,
    module.vpc.private_subnet_3
  ]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    healthy_threshold   = 5
    interval            = 30
    target              = "HTTP:80/index.html"
    timeout             = 10
    unhealthy_threshold = 5
  }
}
