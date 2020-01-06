resource "aws_s3_bucket" "static_files" {
  bucket = var.static_files_bucket
  force_destroy = true
}

resource "aws_s3_bucket_policy" "static_files" {
  bucket = aws_s3_bucket.static_files.id

  policy = <<POLICYJSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::${var.static_files_bucket}/*"
      ]
    }
  ]
}
POLICYJSON
}

output "s3_website_endpoint" {
  value = aws_s3_bucket.static_files.website_endpoint
}

resource "aws_s3_bucket" "cloudfront_logs" {
  bucket = var.cloudfront_logs_bucket
  force_destroy = true
}
