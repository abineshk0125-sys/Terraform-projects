terraform {
  backend "s3" {
    bucket = "abinesh-demo-bucket-2026-03"
    key    = "remote-backend/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}