# main.tf
provider "aws" {
 region = "us-east-1"  
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda.py"
  output_path = "${path.module}/${var.lambda_zip_path}"
}

# IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "lambda_exec_role"
  }
}

# Attach AWSLambdaBasicExecutionRole Policy
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_lambda_function" "udacity_lambda" {
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime

  role = aws_iam_role.lambda_exec_role.arn

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      ENV = "production"
    }
  }

  tags = {
    Name = "UdacityLambda"
  }
}
