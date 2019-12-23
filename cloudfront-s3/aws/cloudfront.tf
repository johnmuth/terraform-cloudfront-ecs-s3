locals {
  s3_origin_id = "cloudfrontEcsS3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = true
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
      cookies {
        forward = "all"
      }
    }
    target_origin_id = local.s3_origin_id
    viewer_protocol_policy = "allow-all"
  }
  origin {
    domain_name = aws_s3_bucket.static_files.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "cloudfront_domain_name" {
  value = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
}
