resource "aws_lambda_function" "dc_secret_rotation" {
  filename         = var.lambda_function_filename
  function_name    = "rds-rotation"
  role             = var.aurora_secret_rotation_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"

   tags = {
    Environment = var.Environment
    Application = "application-db-${var.Environment}"
  }
}