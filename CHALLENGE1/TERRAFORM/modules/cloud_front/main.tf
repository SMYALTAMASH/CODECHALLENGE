resource "aws_cloudfront_distribution" "webapp" {

  origin {
    domain_name = "${var.aws_alb}"

    origin_id = "${var.origin}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"

      origin_ssl_protocols = [
        "SSLv3",
        "TLSv1",
      ]
    }
  }

  #aliases = "${var.cf-webapp-aliases}"

  enabled = true

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  tags {
    Environment = "${var.env}"
  }
  viewer_certificate {
    cloudfront_default_certificate = true
    #ssl_support_method             = "sni-only"
  }
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "alb-app"

    forwarded_values {
      query_string = true
      headers      = ["Host", "Origin"]

      cookies {
        forward           = "none"
      }
    }

    compress               = true
    viewer_protocol_policy = "allow-all"
    min_ttl                = "${var.min_ttl}"
    default_ttl            = "${var.default_ttl}"
    max_ttl                = "${var.max_ttl}"
  }
  ordered_cache_behavior {
    path_pattern     = "/*"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.origin}"

    forwarded_values {
      query_string = true
      headers      = ["Host", "Origin"]

      cookies {
        forward = "all"
      }
    }

    compress               = true
    viewer_protocol_policy = "allow-all"
  }
}