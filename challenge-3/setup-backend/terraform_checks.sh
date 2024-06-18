#!/bin/bash

# Set Colors for Output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# 1. Validate Terraform Syntax
echo -e "${GREEN}Running Terraform validate...${NC}"
terraform validate -no-color
if [ $? -ne 0 ]; then
  echo -e "${RED}Terraform validation failed!${NC}"
  exit 1  # Stop the script if validation fails
fi

# 2. Format Terraform Code
echo -e "${GREEN}Checking Terraform formatting...${NC}"
terraform fmt -check
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Terraform formatting is valid.${NC}"
else
  echo -e "${RED}Terraform formatting needs corrections. Run 'terraform fmt' to fix.${NC}"
  terraform fmt -diff > formatting_diff.txt
  exit 1 # Stop the script to see formatting errors before applying
fi

# 3. Run TFLint
echo -e "${GREEN}Running TFLint...${NC}"
tflint --format=json > tflint_output.json

# 4. Run tfsec
echo -e "${GREEN}Running tfsec...${NC}"
tfsec . --config-file .tfsec.yaml --format json > tfsec_output.json

echo -e "${GREEN}All checks passed!${NC}"