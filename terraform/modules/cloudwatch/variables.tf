variable "cloudwatch_rule_name" {
  description = "Event rule name"
  type = string
}

variable "lambda_arn" {
  description = "Lambda ARN"
  type = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type = string
}

variable "lambda_schedule_expression" {
  description = "Lambda schedule expression. Defaults to every 5 minutes"
  type = string
  default     = "rate(5 minutes)"
}