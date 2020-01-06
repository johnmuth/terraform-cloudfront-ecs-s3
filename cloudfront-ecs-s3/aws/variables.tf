variable "webapp_id" {
  type = string
  description = "Webapp id is used as an identifier for various bits of the ECS infrastructure. ECR repository name, ECS cluster name, ECS service name, cloudwatch log group."
}
variable "aws_region" {
  type = string
}
variable "static_files_bucket" {
  type = string
}
variable "cloudfront_logs_bucket" {
  type = string
}

variable "terraform_state_bucket" {
  type = string
}
