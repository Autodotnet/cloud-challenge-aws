output "cf_domain_name" {
  value       = aws_cloudfront_distribution.main.domain_name
  description = "Cloudfront domain"
}