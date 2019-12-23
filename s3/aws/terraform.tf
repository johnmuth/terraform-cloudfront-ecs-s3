terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-name"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}
