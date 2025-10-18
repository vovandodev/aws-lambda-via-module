# Data source to get current AWS account information
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Reference to the Lambda module from tfc
module "lambda_function" {
  source  = "app.terraform.io/vvrubl-hashicorp/lambda/aws"
  version = "8.1.0"

  function_name = "my-lambda1"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.12"

  source_path = "./src/lambda-function1"

  # Environment variables
  environment_variables = {
    ENVIRONMENT = var.environment
    LOG_LEVEL   = "INFO"
  }

  # Memory and timeout configuration
  memory_size = 256
  timeout     = 30

  # Enable CloudWatch logging
  create_current_version_allowed_triggers = false

  tags = {
    Name        = "my-lambda1"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# Optional: CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda_logs" {
  count = var.create_log_group ? 1 : 0
  
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.log_retention_days
  
  tags = merge(var.tags, {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  })
}
