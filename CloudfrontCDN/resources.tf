provider "aws" {
  region = "${var.region}"
}

//cloudfront resource
resource "aws_cloudfront_distribution" "MySiteS3" {
  origin {
    custom_origin_config {
      http_port= "80"
      https_port = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = "${var.S3WebsiteEndpoint}"
    origin_id = "${var.subDomain}"
  }
  enabled = true
  default_root_object = "index.html"

  //default from aws
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    // This needs to match the `origin_id` above.
    target_origin_id       = "${var.subDomain}"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  aliases =  ["${var.subDomain}"]
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn = "${var.RootCertificateARN}"
    ssl_support_method  = "sni-only"
  }
}

output "CloudfrontDistributionName" {
  value = "${aws_cloudfront_distribution.MySiteS3.domain_name}"
}

output "CloudfrontZoneID" {
  value = "${aws_cloudfront_distribution.MySiteS3.hosted_zone_id}"
}


