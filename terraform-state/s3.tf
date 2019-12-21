provider "aws" {
  region = "eu-west-2"
}
resource "aws_s3_bucket" "cloudfront_ecs_s3_terraform_state_test" {
  bucket = "cloudfront-ecs-s3-terraform-state-test"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Cloudfront ECS S3 Terraform State - Test"
  }
}
