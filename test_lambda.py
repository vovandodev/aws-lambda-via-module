#!/usr/bin/env python3
"""
Test script for the Lambda function
This script can be used to test the Lambda function locally before deployment
"""

import json
import sys
import os

# Add the src directory to the path so we can import our Lambda function
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src', 'lambda-function1'))

from index import lambda_handler

class MockContext:
    """Mock AWS Lambda context for testing"""
    def __init__(self):
        self.function_name = "my-lambda1"
        self.function_version = "$LATEST"
        self.invoked_function_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-lambda1"
        self.memory_limit_in_mb = 256
        self.remaining_time_in_millis = lambda: 30000
        self.aws_request_id = "test-request-id-12345"
        self.log_group_name = "/aws/lambda/my-lambda1"
        self.log_stream_name = "2024/01/01/[$LATEST]test-stream"

def test_lambda_function():
    """Test the Lambda function with sample events"""
    
    # Set environment variables
    os.environ['ENVIRONMENT'] = 'test'
    os.environ['LOG_LEVEL'] = 'INFO'
    
    # Create mock context
    context = MockContext()
    
    # Test 1: Basic GET request
    print("=== Test 1: Basic GET Request ===")
    event1 = {
        "httpMethod": "GET",
        "path": "/",
        "headers": {
            "Content-Type": "application/json"
        },
        "queryStringParameters": {
            "name": "test-user"
        }
    }
    
    response1 = lambda_handler(event1, context)
    print(f"Status Code: {response1['statusCode']}")
    print(f"Response Body: {response1['body']}")
    print()
    
    # Test 2: POST request with body
    print("=== Test 2: POST Request with Body ===")
    event2 = {
        "httpMethod": "POST",
        "path": "/api/test",
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "message": "Hello from test",
            "data": {"key": "value"}
        })
    }
    
    response2 = lambda_handler(event2, context)
    print(f"Status Code: {response2['statusCode']}")
    print(f"Response Body: {response2['body']}")
    print()
    
    # Test 3: Request with path parameters
    print("=== Test 3: Request with Path Parameters ===")
    event3 = {
        "httpMethod": "GET",
        "path": "/api/users/123",
        "pathParameters": {
            "id": "123"
        },
        "headers": {
            "Content-Type": "application/json"
        }
    }
    
    response3 = lambda_handler(event3, context)
    print(f"Status Code: {response3['statusCode']}")
    print(f"Response Body: {response3['body']}")
    print()
    
    # Test 4: Error handling
    print("=== Test 4: Error Handling ===")
    # This test would trigger an error if we had error-prone code
    event4 = {
        "httpMethod": "GET",
        "path": "/",
        "headers": {}
    }
    
    response4 = lambda_handler(event4, context)
    print(f"Status Code: {response4['statusCode']}")
    print(f"Response Body: {response4['body']}")

if __name__ == "__main__":
    test_lambda_function()
