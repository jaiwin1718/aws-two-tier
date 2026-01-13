terraform {
   backend "s3" {
    bucket         = "aws-tf-test-bkt-1718"
    key            = "terraform/state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# # Configure the AWS Provider
# provider "aws" {
#   region = "us-east-1"
# }


