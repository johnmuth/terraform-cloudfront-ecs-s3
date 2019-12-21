resource "aws_s3_bucket" "cloudfront_ecs_s3" {
  bucket = "cloudfront-ecs-s3"
  acl    = "private"
  tags = {
    Name = "Cloudfront ECS S3"
  }
}
