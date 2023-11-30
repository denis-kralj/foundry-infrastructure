variable "notification_email" {
  type = string
}

resource "aws_sns_topic" "server-uptime-topic" {
  name = "server-uptime-topic"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.server-uptime-topic.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_cloudwatch_metric_alarm" "server-uptime-alarm" {
  alarm_name          = "server-uptime-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  period              = 43200 # 43200 = 12h
  threshold           = 0
  statistic           = "Sum" # will always be more than 0, and will just push when period is reached
  alarm_description   = "Server uptime monitor and alert"
  alarm_actions       = [aws_sns_topic.server-uptime-topic.arn]

  dimensions = {
    InstanceId = module.foundry.instance_id
  }
}
