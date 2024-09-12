provider "aws" {
  access_key = "AKIASUDX4I3XX32SI34M"
  secret_key = "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"
  region = "us-east-1"
}

# Provides an IAM role
resource "aws_iam_role" "iam_role" {
  name = "iam_role_x"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Provides an IAM policy
resource "aws_iam_policy" "iam_policy" {
  name        = "iam_policy_x"
  path        = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Attaches a Managed IAM Policy to an IAM role
resource "aws_iam_role_policy_attachment" "attaches_role_policy"{
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

# Provides a CloudWatch Log Group resource
resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "${var.lambda_log_group_name}/${var.lambda_name}"
  retention_in_days = var.retention_in_days
}

data "archive_file" "lambdatypezip" {
    type = "zip"
    source_file = "greet_lambda.py"
    output_path = var.lambda_output
}

# Provides a Lambda Function resource
resource "aws_lambda_function" "resource_lambda" {
  function_name = var.lambda_name
  filename = data.archive_file.lambdatypezip.output_path
  role = aws_iam_role.iam_role.arn
  source_code_hash = data.archive_file.lambdatypezip.output_base64sha256
  handler = "greet_lambda.lambda_handler"
  runtime = "python3.8"

  environment{
      variables = {
          greeting = "Welcome to lambda function!"
      }
  }
depends_on = [aws_iam_role_policy_attachment.attaches_role_policy, aws_cloudwatch_log_group.cloudwatch_log_group]
}
