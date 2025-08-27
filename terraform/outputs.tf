
output "cf_domain" {
  value = module.frontend.cf_domain_name
  
}

output "url_endpoint" {
  value = module.backend.url
  
}