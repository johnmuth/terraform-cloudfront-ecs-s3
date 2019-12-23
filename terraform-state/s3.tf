provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "johnmuth-terraform-cloudfront-ecs-s3-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Terraform State"
  }
}
