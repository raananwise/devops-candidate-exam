provider "aws" {
  region  = "ap-south-1" # Don't change the region
}

# Add your S3 backend configuration here

terraform {
  backend "s3" {
    #key = "terraform.tfstate"
    key = "Avi.Han"

  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # version = "~> 4.50"
    }
  }
}

resource "aws_s3_bucket" "terraform_s3_devops_exam" {
  bucket = "3.devops.candidate.exam"
  provider = "aws"

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = true
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }

}

