# This .tf file creates the aws cloudfront infra.

#resource "aws_cloudfront_origin_access_identity" "anne_test_website_cdn_origin_id" {}

resource "aws_cloudfront_distribution" "anne_s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.anne_test_website.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    origin_access_control_id = aws_cloudfront_origin_access_control.anne_website_cdn_access_control.id

    #    this is to use the Cloudfront OAI rather than recommended origin access control
    #    s3_origin_config {
    #      origin_access_identity = aws_cloudfront_origin_access_identity.anne_test_website_cdn_origin_id.cloudfront_access_identity_path
    #      origin_access_identity = aws_cloudfront_origin_access_control.anne_website_cdn_access_control.
    #    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "anne website cdn"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "NZ", "AU"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


# This is implemented but not yet being used, the reason is that there is no way to specify to choose use OAC rather than OAI to access the S3 bucket.
resource "aws_cloudfront_origin_access_control" "anne_website_cdn_access_control" {
  name                              = "anne-website-access-control"
  description                       = "This access control is used for cloudfront to access S3 bucket of anne-tes-website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}