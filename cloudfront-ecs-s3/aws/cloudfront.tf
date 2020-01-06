locals {
  s3_origin_id = "s3"
  alb_origin_id = "alb"
}

resource "aws_cloudfront_distribution" "s3_alb" {
  enabled = true
  origin {
    domain_name = aws_s3_bucket.static_files.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
  }
  origin {
    domain_name = aws_alb.webapp.dns_name
    origin_id   = local.alb_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.alb_origin_id
    default_ttl = 0
    min_ttl     = 0
    max_ttl     = 0
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
  }
  ordered_cache_behavior {
    path_pattern     = "/assets/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    target_origin_id = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  logging_config {
    bucket = aws_s3_bucket.cloudfront_logs.bucket_domain_name
  }
  depends_on = [aws_s3_bucket.cloudfront_logs]
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_alb.domain_name
}
