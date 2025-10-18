# Outputs for AWS Lambda configuration

output "lambda_function_arn" {
  description = "The Amazon Resource Name (ARN) of the Lambda function"
  value       = module.lambda_function.function_arn
}

output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = module.lambda_function.function_name
}

output "lambda_function_invoke_arn" {
  description = "The ARN to be used for invoking Lambda function from API Gateway"
  value       = module.lambda_function.function_invoke_arn
}

output "lambda_function_qualified_arn" {
  description = "The qualified ARN (ARN with version number) of the Lambda function"
  value       = module.lambda_function.function_qualified_arn
}

output "lambda_function_version" {
  description = "The version of the Lambda function"
  value       = module.lambda_function.function_version
}

output "lambda_function_last_modified" {
  description = "The date this resource was last modified"
  value       = module.lambda_function.function_last_modified
}

output "lambda_function_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file"
  value       = module.lambda_function.function_source_code_hash
}

output "lambda_function_source_code_size" {
  description = "The size in bytes of the function .zip file"
  value       = module.lambda_function.function_source_code_size
}

output "lambda_role_arn" {
  description = "The ARN of the IAM role created for the Lambda function"
  value       = module.lambda_function.role_arn
}

output "lambda_role_name" {
  description = "The name of the IAM role created for the Lambda function"
  value       = module.lambda_function.role_name
}

output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = var.create_log_group ? aws_cloudwatch_log_group.lambda_logs[0].name : null
}

output "cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch log group"
  value       = var.create_log_group ? aws_cloudwatch_log_group.lambda_logs[0].arn : null
}

output "aws_region" {
  description = "The AWS region where resources are created"
  value       = data.aws_region.current.name
}

output "aws_account_id" {
  description = "The AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}