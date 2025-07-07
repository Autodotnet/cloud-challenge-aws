locals {
  s3_bucket_name = "test-website-xyz71733469"
  domain         = "www.umamicloudchallenge.org"
  cert_arn       = "arn:aws:acm:us-east-1:868948464703:certificate/e62cda49-172b-44cf-9364-9fee70e93d92"

}



resource "aws_s3_bucket" "main" {
  bucket        = local.s3_bucket_name
  force_destroy = true
}


resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  aliases             = [local.domain]
  default_root_object = "index.html"
  wait_for_deployment = true


  default_cache_behavior {
    allowed_methods        = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods         = ["HEAD", "GET", "OPTIONS"]
    target_origin_id       = aws_s3_bucket.main.bucket
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"

  }

  origin {
    domain_name              = aws_s3_bucket.main.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
    origin_id                = aws_s3_bucket.main.bucket
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = local.cert_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

}


resource "aws_cloudfront_origin_access_control" "main" {
  name                              = "s3-cloudfront-oac2"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_iam_policy_document" "cloudfront_oac_access" {
  statement {
    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.main.arn}/*"]

    condition {
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.main.arn]
      variable = "AWS:SourceArn"
    }
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.cloudfront_oac_access.json
}

resource "null_resource" "upload_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync www s3://${aws_s3_bucket.main.id} --profile dev-test"
  }
  
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.main.id} --paths '/*' --profile dev-test"
  }
  
  triggers = {
    always_run = timestamp()
  }
}