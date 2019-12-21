resource "aws_s3_bucket" "cloudfront_ecs_s3" {
  bucket = "cloudfront-ecs-s3"
}

resource "aws_s3_bucket_policy" "cloudfront_ecs_s3" {
  bucket = aws_s3_bucket.cloudfront_ecs_s3.id

  policy = file("s3-bucket-policy.json")
}
