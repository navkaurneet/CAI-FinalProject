# Create the S3 bucket for storing Terraform state
resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket_name
}

# Block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.tfstate.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Create the DynamoDB table for state locking
resource "aws_dynamodb_table" "state_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Define the VPC (this part remains the same as in your original config)
resource "aws_vpc" "nav_vpc_8946587" {
  cidr_block = var.vpc_cidr_block
}

# Create the subnet
resource "aws_subnet" "nav_subnet_8946587" {
  count           = length(var.subnet_cidr_blocks)
  vpc_id          = aws_vpc.nav_vpc_8946587.id
  cidr_block      = var.subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true
}

# Security group for the EC2 instance
resource "aws_security_group" "nav_web_sg_8946587" {
  vpc_id = aws_vpc.nav_vpc_8946587.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance configuration
resource "aws_instance" "nav_web_server_8946587" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.nav_subnet_8946587[0].id
  vpc_security_group_ids = [aws_security_group.nav_web_sg_8946587.id]

  tags = {
    Name = "Nav8946587-WebServer"
  }
}
