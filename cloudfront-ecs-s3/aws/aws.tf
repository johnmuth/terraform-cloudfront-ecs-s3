provider "aws" {
  region = "eu-west-2"
}
data "aws_caller_identity" "current" {}
