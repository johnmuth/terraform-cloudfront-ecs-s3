resource "aws_s3_bucket" "static_files" {
  bucket = "johnmuth-terraform-cloudfront-ecs-s3-static-files"
}

resource "aws_s3_bucket_policy" "static_files" {
  bucket = aws_s3_bucket.static_files.id

  policy = file("s3-bucket-policy.json")
}
