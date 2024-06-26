#Event Rule to Start EC2

resource "aws_cloudwatch_event_rule" "stop_ec2" {
  name        = "Stop_EC2_Rule"
  description = "Stop Ec2 instances"
  schedule_expression = "cron(00 17 * * ? *)" 
}

resource "aws_cloudwatch_event_target" "stop_ec2" {
  rule      = aws_cloudwatch_event_rule.stop_ec2.name
  target_id = "stop_lambda"
  arn = "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:stop_lambda"
}




#Event Rule to Start EC2

resource "aws_cloudwatch_event_rule" "start_ec2" {
  name        = "Start_EC2_Rule"
  description = "Start Ec2 instances"
  schedule_expression = "cron(00 9 * * ? *)"
}

resource "aws_cloudwatch_event_target" "start_ec2" {
  rule      = aws_cloudwatch_event_rule.start_ec2.name
  target_id = "start_lambda"
  arn = "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:start_lambda"
}


