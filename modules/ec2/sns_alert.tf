#sns email
data "template_file" "aws_cf_sns_email_stack" {
  template = file("./templates/cf_aws_sns_email_stack.json.tpl")
  vars = {
    sns_topic_name   = var.sns_topic_name
    sns_display_name = var.sns_topic_display_name
    sns_subscription_list = join(",", formatlist("{\"Endpoint\": \"%s\",\"Protocol\": \"%s\"}",
      var.sns_subscription_email_address_list,
    var.sns_subscription_protocol))
  }
}

resource "aws_cloudformation_stack" "tf_sns_topic" {
  name          = "sns-alert-email-stack"
  template_body = data.template_file.aws_cf_sns_email_stack.rendered
  tags = {
    name = "sns-email-alert"
  }
}

#sns topic
resource "aws_sns_topic" "webserver_autoscaling_alert_topic" {
  display_name = "webserver-autoscaling-topic"
  name         = "webserver-autoscaling-topic"
}

/*
#sns phone
resource "aws_sns_topic_subscription" "webserver_autoscaling_sms_subscription" {
  endpoint  = "<<phone-number-with-code>>"
  protocol  = "sms"
  topic_arn = aws_sns_topic.webserver_autoscaling_alert_topic.arn
}

#sns topic
resource "aws_autoscaling_notification" "webserver_autoscaling_notification" {
  group_names = [aws_autoscaling_group.public_autoscaling_group.name]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]
  topic_arn = aws_sns_topic.webserver_autoscaling_alert_topic.arn
}
*/
