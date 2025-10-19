#!/bin/bash

# =============================
# Northwind Bikes ARM Deployment
# =============================

# Resource Group (pre-existing)
RG="Student-RG-1879876"

# Deployment name
DEPLOYMENT_NAME="northwind-deploy"

# Template and parameters
TEMPLATE_FILE="azuredeploy.json"
PARAMS_FILE="azuredeploy.parameters.json"

# Check if Azure CLI is installed
if ! command -v az &> /dev/null
then
    echo "Azure CLI not found. Please install it first."
    exit 1
fi

# =============================
# Validate ARM template first
# =============================
echo "Validating ARM template..."
az deployment group validate \
  --resource-group $RG \
  --name $DEPLOYMENT_NAME \
  --template-file $TEMPLATE_FILE \
  --parameters @$PARAMS_FILE

if [ $? -ne 0 ]; then
    echo "Template validation failed ❌ Fix errors and retry."
    exit 1
else
    echo "Validation passed ✅ Proceeding with deployment..."
fi

# =============================
# Deploy ARM template
# =============================
echo "Deploying ARM template..."
az deployment group create \
  --resource-group $RG \
  --name $DEPLOYMENT_NAME \
  --template-file $TEMPLATE_FILE \
  --parameters @$PARAMS_FILE \
  --query "properties.outputs" \
  --output json > deployment-output.json

# =============================
# Parse outputs using jq
# =============================
PUBLIC_IP=$(jq -r '.publicIP.value' deployment-output.json)
WEBSITE_URL=$(jq -r '.websiteURL.value' deployment-output.json)
SSH_HINT=$(jq -r '.sshHint.value' deployment-output.json)

echo ""
echo "================ Deployment Outputs ================"
echo "Public IP: $PUBLIC_IP"
echo "Website URL: $WEBSITE_URL"
echo "SSH Hint: $SSH_HINT"
echo "==================================================="
echo ""

# =============================
# Quick web test
# =============================
echo "Testing website HTTP response..."
curl -I $WEBSITE_URL

