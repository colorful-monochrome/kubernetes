terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "terraform-remotestate-60458"
    encrypt        = true # Optional, S3 Bucket Server Side Encryption
    key            = "tf-remote-state/terraform.tfstate"
    dynamodb_table = "tf-remote-state-lock"

  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
