# TODO: Define the variable for aws_region
variable "lambda_name" {
  default = "function_lambda_name_x"
}

variable "lambda_log_group_name" {
  default = "/aws/lambda"
}

variable "lambda_output" {
  default = "lambdaoutput.zip"
}

variable "retention_in_days" {
  default = "90"
}

