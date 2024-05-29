resource "aws_cloudwatch_event_rule" "cloudwatch_on_scaling_termination" {
  name        = "cloudwatch-on-scaling-termination-rule"
  description = "Capture the event when autoscaling group has reached to minimum instances (default is -1)"
  event_pattern = jsonencode({
    source = [
      "aws.autoscaling"
    ]
    detail-type = [
      "EC2 Instance Terminate Successful"
    ]
  })
}


resource "aws_cloudwatch_event_target" "lambda" {
  arn       = aws_lambda_function.finance_report_function.arn
  rule      = aws_cloudwatch_event_rule.cloudwatch_on_scaling_termination.arn
  target_id = "SendToLambda"
}
