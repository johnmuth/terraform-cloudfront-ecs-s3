terraform {
  backend "s3" {
    bucket = "johnmuth-terraform-cloudfront-ecs-s3-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}
