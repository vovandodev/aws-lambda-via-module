# AWS Lambda via Private Module

This Terraform configuration creates an AWS Lambda function using a private module from your Terraform Cloud registry.

## Prerequisites

1. **Terraform Cloud Organization**: You need a Terraform Cloud organization with access to a private module registry
2. **AWS Credentials**: Configure AWS credentials in your Terraform Cloud workspace
3. **Private Module**: Ensure you have access to the Lambda module in your private registry

## Setup Instructions

### 1. Update Configuration

Before using this configuration, update the following files:

#### `terraform.tf`
- Replace `YOUR_ORG_NAME` with your actual Terraform Cloud organization name
- Update the workspace name if needed

#### `main.tf`
- Replace `YOUR_ORG_NAME` in the module source with your actual organization name
- Update the module name if different from `lambda/aws`

### 2. Configure Variables

1. Copy `terraform.tfvars.example` to `terraform.tfvars`
2. Customize the variables according to your requirements

### 3. Initialize and Apply

```bash
# Initialize Terraform (this will connect to Terraform Cloud)
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## Module Reference

This configuration references a private Lambda module with the following structure:

```
module "lambda_function" {
  source = "app.terraform.io/YOUR_ORG_NAME/lambda/aws"
  # ... configuration parameters
}
```

## Key Features

- **Flexible Configuration**: Supports various Lambda runtimes and configurations
- **VPC Support**: Optional VPC configuration for Lambda functions
- **CloudWatch Integration**: Automatic log group creation with configurable retention
- **IAM Integration**: Automatic IAM role creation with appropriate permissions
- **Environment Variables**: Support for custom environment variables
- **Tagging**: Comprehensive tagging strategy for resource management

## Variables

See `variables.tf` for a complete list of configurable parameters. Key variables include:

- `lambda_function_name`: Name of the Lambda function
- `lambda_runtime`: Runtime environment (python3.9, nodejs20.x, etc.)
- `lambda_handler`: Function entrypoint
- `source_path`: Path to source code
- `environment_variables`: Environment variables map
- `vpc_config_enabled`: Enable VPC configuration
- `memory_size`: Memory allocation in MB
- `timeout`: Function timeout in seconds

## Outputs

The configuration provides several useful outputs:

- `lambda_function_arn`: ARN of the created Lambda function
- `lambda_function_name`: Name of the function
- `lambda_function_invoke_arn`: ARN for API Gateway integration
- `lambda_role_arn`: ARN of the IAM role
- `cloudwatch_log_group_name`: Name of the log group

## Example Usage

```hcl
# Use the outputs in other configurations
data "terraform_remote_state" "lambda" {
  backend = "remote"
  config = {
    organization = "your-org"
    workspaces = {
      name = "aws-lambda-module"
    }
  }
}

# Reference the Lambda function ARN
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id = aws_api_gateway_resource.example.id
  http_method = aws_api_gateway_method.example.http_method
  integration_http_method = "POST"
  type                   = "AWS_PROXY"
  uri                    = data.terraform_remote_state.lambda.outputs.lambda_function_invoke_arn
}
```

## Security Considerations

- Ensure your Lambda function code is properly secured
- Use least-privilege IAM policies
- Enable VPC configuration if your Lambda needs to access private resources
- Consider using AWS Secrets Manager for sensitive environment variables

## Troubleshooting

1. **Module Not Found**: Verify the module source path and your organization name
2. **Permission Issues**: Ensure your Terraform Cloud workspace has access to the private registry
3. **AWS Permissions**: Verify AWS credentials have sufficient permissions for Lambda and IAM operations

## Contributing

When making changes to this configuration:

1. Update variable descriptions if adding new variables
2. Test with different runtime environments
3. Ensure backward compatibility with existing deployments
4. Update this README if adding new features