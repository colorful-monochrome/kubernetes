provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

variable "aws_dynamodb_table" {
  type = string
}
resource "random_id" "rmstate-id" {
  byte_length = 2
}
resource "aws_s3_bucket" "tfrmstate" {
  bucket        = "terraform-remotestate-${random_id.rmstate-id.dec}"
  acl           = "private"
  force_destroy = true # This will allow the bucket to be destroy via terrafor destroy.

  tags = {
    owner = "edgdejes"
  }
}

resource "aws_s3_bucket_object" "rmstate_folder" {
  bucket = aws_s3_bucket.tfrmstate.id
  key    = "tf-remote-state/"
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = var.aws_dynamodb_table
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
