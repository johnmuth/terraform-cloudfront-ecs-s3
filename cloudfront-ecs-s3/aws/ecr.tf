resource "aws_ecr_repository" "webapp" {
  name                 = var.webapp_id
}

resource "null_resource" "docker_publish" {
  provisioner "local-exec" {
    command = "docker build -t ${var.webapp_id}:latest ./hello-world-webapp && docker tag ${var.webapp_id}:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.webapp_id} && $(aws ecr get-login --no-include-email --region ${var.aws_region}) && docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.webapp_id}:latest"
  }
}

data "aws_ecr_image" "webapp_image" {
  depends_on = [null_resource.docker_publish]
  repository_name = "${aws_ecr_repository.webapp.name}"
  image_tag       = "latest"
}
