terraform {
  backend "s3" {
    bucket = "var.terraform_state_bucket"
    key    = "terraform.tfstate"
    region = var.aws_region
  }
}
