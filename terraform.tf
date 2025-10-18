# Terraform Cloud configuration
terraform {
  # Terraform Cloud backend configuration
  cloud {
    organization = "vvrubl-hashicorp"  # Replace with your Terraform Cloud organization name
    workspaces {
      name = "aws-lambda-via-module"  # Replace with your desired workspace name
    }
  }

  # Required providers
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Terraform version constraint
  required_version = ">= 1.0"
}