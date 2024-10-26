# outputs.tf

output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.udacity_lambda.function_name
}

output "lambda_function_arn" {
  description = "ARN Lambda function name"
  value       = aws_lambda_function.udacity_lambda.arn
}
