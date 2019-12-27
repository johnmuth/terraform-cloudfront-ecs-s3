resource "aws_ecr_repository" "webapp" {
  name                 = "johnmuth-terraform-cloudfront-ecs-s3-webapp"
}

resource "null_resource" "docker_publish" {
  provisioner "local-exec" {
    command = "docker build -t johnmuth-terraform-cloudfront-ecs-s3-webapp:latest ./hello-world-webapp && docker tag johnmuth-terraform-cloudfront-ecs-s3-webapp:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-west-2.amazonaws.com/johnmuth-terraform-cloudfront-ecs-s3-webapp && $(aws ecr get-login --no-include-email --region eu-west-2) && docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-west-2.amazonaws.com/johnmuth-terraform-cloudfront-ecs-s3-webapp:latest"
  }
}

data "aws_ecr_image" "webapp_image" {
  depends_on = [null_resource.docker_publish]
  repository_name = "${aws_ecr_repository.webapp.name}"
  image_tag       = "latest"
}
