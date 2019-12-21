terraform {
  backend "s3" {
    bucket = "cloudfront-ecs-s3-terraform-state-test"
    key    = "cloudfront-ecs-s3/terraform.tfstate"
    region = "eu-west-2"
  }
}
