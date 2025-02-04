#!/bin/bash

# Set AWS credentials
export aws_region="eu-west-1"

# Define the name of the secret
secret_name="MakiSecret"


# Retrieve secret values from Secrets Manager
secret_values=$(aws secretsmanager get-secret-value --region "$aws_region" --secret-id "$secret_name" --query 'SecretString' --output text)

# Check if there's an error retrieving the secret values
if [ $? -ne 0 ]; then
  echo "Error: Failed to retrieve secret values from Secrets Manager."
  exit 1
fi

# Check if the secret values are empty
if [ -z "$secret_values" ]; then
  echo "Error: Secret values are empty."
  exit 1
fi

# Parse secret values into key/value pairs using jq
env_content=$(echo "$secret_values" | jq -r 'to_entries[] | "\(.key)=\(.value)"')

# Check if there's an error parsing the secret values
if [ $? -ne 0 ]; then
  echo "Error: Failed to parse secret values into key/value pairs."
  exit 1
fi

# Store key/value pairs in an env file
echo "$env_content" > .env

# Check if there's an error storing the key/value pairs
if [ $? -ne 0 ]; then
  echo "Error: Failed to store key/value pairs in secret.env file."
  exit 1
fi

echo "Secret values retrieved and stored in secret.env file."