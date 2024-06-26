
# Lambda Function Configuration
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir = "lambda-script"
  output_path = "lambda_function.zip"
}

#Lambda that Stops EC2 

resource "aws_lambda_function" "stop_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "stop_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "stop.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_lambda.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.stop_ec2.arn
}



resource "aws_lambda_function" "start_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "start_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "start.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start_lambda.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.start_ec2.arn
}

