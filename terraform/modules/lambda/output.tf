output "lambda_arn" {
  description = "The Amazon Resource Name (ARN) specifying the Lambda"
  value       = aws_lambda_function.source.arn
}