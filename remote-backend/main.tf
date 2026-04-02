provider "aws" {
    region = "us-east-1" 
}

resource "aws_instance" "Abinesh" {
    instance_type = "t3.micro"
    ami="ami-0ec10929233384c7f"
}

resource "aws_s3_bucket" "s2_bucket" {
    bucket = "abinesh-demo-bucket-2026-03"
      
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform_lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
