## AWS Infrastructure Automation with Terraform

**Project Overview**
This project demonstrates Infrastructure as Code (IaC) principles by automating the deployment of AWS infrastructure using Terraform. Key resources include:

**S3 Bucket**: Stores Terraform state files with versioning.
**DynamoDB Table**: Enables state locking to prevent concurrent updates.
**VPC**: Includes at least one public subnet.
**EC2 Instance**: Configured with a public IP, security groups, and SSH/HTTP access.

## Prerequisites
To complete this project, ensure the following:

Terraform Installed: Use the latest version from the Terraform website.
AWS CLI Configured: Set up AWS CLI with access keys.
IAM Permissions: Your AWS credentials should allow S3, EC2, VPC, and DynamoDB operations.
Unique S3 Bucket Name: Bucket names must be globally unique.

## Deployment Steps

**Clone the Repository:**

git clone <repository-url>
cd <repository-directory>

Initialize Terraform: Initialize Terraform to download provider plugins and set up the backend:

    terraform init

Review the Plan: Review the resources that Terraform will create:

    terraform plan

Apply the Configuration: Deploy the resources to AWS:

    terraform apply

## Verify Resources:

Log in to the AWS Management Console.
Check the created S3 bucket, EC2 instance, VPC, and related configurations.

## File Descriptions
**backend.tf**: Configures the S3 bucket and DynamoDB table for the Terraform backend.
**main.tf**: Defines AWS resources including the S3 bucket, EC2 instance, and VPC.
**variables.tf**: Contains variable definitions for resource configuration.
**terraform.tfvars**: Stores actual values for variables (excluded from version control for security).
**provider.tf**: Sets up the AWS provider.
**README.md**: Project documentation.

## Best Practices
**Modular Configuration**: Variables are used for flexibility and to avoid hardcoding.
**Backend Management**: The S3 backend with versioning ensures reliable state tracking.
**Security**: Sensitive data is stored locally in terraform.tfvars and not committed to GitHub.
**State Locking**: DynamoDB table (if implemented) prevents concurrent state file updates.

## Notes
**Bucket Name**: Ensure the S3 bucket name is unique to avoid deployment failures.
**Terraform Backend**: Update the backend.tf file or use a backend-config.hcl file for dynamic backend configuration.
**Sensitive Data**: Never push access keys or sensitive data to public.

## Useful commands:
Manual Creation of Resources: By manually creating the S3 bucket and DynamoDB table, you ensure that the backend configuration can properly reference these resources during initialization.

# Create the S3 bucket
aws s3api create-bucket --bucket nav-store-tfstate --region us-east-1 --output json

# Enable versioning on the S3 bucket
aws s3api put-bucket-versioning --bucket nav-store-tfstate --versioning-configuration Status=Enabled --output json

# general Amazon Linux AMI: 
aws ec2 describe-images --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" --query "Images[].[ImageId, Name]" --region us-east-1
