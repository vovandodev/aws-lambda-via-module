# Variables for AWS Lambda configuration

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "my-lambda-function"
}

variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
  default     = "python3.9"
  validation {
    condition = contains([
      "python3.8", "python3.9", "python3.10", "python3.11", "python3.12",
      "nodejs18.x", "nodejs20.x",
      "java8", "java11", "java17", "java21",
      "dotnet6", "dotnet8",
      "go1.x", "provided.al2"
    ], var.lambda_runtime)
    error_message = "Lambda runtime must be a valid AWS Lambda runtime."
  }
}

variable "lambda_handler" {
  description = "Function entrypoint in your code"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "source_path" {
  description = "Path to the source code directory"
  type        = string
  default     = "./src"
}

variable "filename" {
  description = "Path to the function's deployment package"
  type        = string
  default     = null
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "create_iam_role" {
  description = "Whether to create an IAM role for the Lambda function"
  type        = bool
  default     = true
}

variable "iam_role_name" {
  description = "Name of the IAM role for the Lambda function"
  type        = string
  default     = null
}

variable "vpc_config_enabled" {
  description = "Whether to enable VPC configuration for the Lambda function"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "List of subnet IDs for VPC configuration"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of security group IDs for VPC configuration"
  type        = list(string)
  default     = []
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda function can use"
  type        = number
  default     = 128
  validation {
    condition = var.memory_size >= 128 && var.memory_size <= 10240
    error_message = "Memory size must be between 128 and 10240 MB."
  }
}

variable "timeout" {
  description = "Function execution time limit in seconds"
  type        = number
  default     = 3
  validation {
    condition = var.timeout >= 1 && var.timeout <= 900
    error_message = "Timeout must be between 1 and 900 seconds."
  }
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition = contains(["dev", "staging", "prod", "development", "production"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, development, production."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "lambda-project"
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "create_log_group" {
  description = "Whether to create a CloudWatch log group for the Lambda function"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "CloudWatch log group retention period in days"
  type        = number
  default     = 14
  validation {
    condition = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.log_retention_days)
    error_message = "Log retention days must be a valid AWS CloudWatch retention period."
  }
}