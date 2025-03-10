#!/bin/bash

echo "Fetching AWS Credentials from AWS Secrets Manager..."

# Ensure AWS CLI uses the correct region
AWS_REGION=${AWS_REGION:-"ap-south-1"}  # Set default region if not provided
export AWS_REGION

# Ensure AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are available
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "Error: AWS credentials are missing! Ensure they are set in credentials.env."
    exit 1
fi

# Fetch AWS credentials from AWS Secrets Manager
AWS_CREDENTIALS_JSON=$(aws secretsmanager get-secret-value --region "$AWS_REGION" --secret-id aws-credentials --query SecretString --output text)

# Check if the fetch command was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to retrieve AWS credentials from Secrets Manager!"
    exit 1
fi

# Extract AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY from JSON response
EXTRACTED_AWS_ACCESS_KEY_ID=$(echo "$AWS_CREDENTIALS_JSON" | jq -r '.AWS_ACCESS_KEY_ID')
EXTRACTED_AWS_SECRET_ACCESS_KEY=$(echo "$AWS_CREDENTIALS_JSON" | jq -r '.AWS_SECRET_ACCESS_KEY')

# Fetch SSH Private Key
SSH_PRIVATE_KEY=$(aws secretsmanager get-secret-value --region "$AWS_REGION" --secret-id ssh-private-key --query SecretString --output text | jq -r '.SSH_PRIVATE_KEY')

# Validate the retrieved values
if [ -z "$EXTRACTED_AWS_ACCESS_KEY_ID" ] || [ -z "$EXTRACTED_AWS_SECRET_ACCESS_KEY" ] || [ -z "$SSH_PRIVATE_KEY" ]; then
    echo "Error: One or more AWS secrets are missing or empty!"
    exit 1
fi

# Export the retrieved secrets
export AWS_ACCESS_KEY_ID="$EXTRACTED_AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$EXTRACTED_AWS_SECRET_ACCESS_KEY"
export SSH_PRIVATE_KEY

echo "AWS Credentials and SSH Private Key fetched successfully!"