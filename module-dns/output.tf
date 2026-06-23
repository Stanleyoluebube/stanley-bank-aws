output "route53_zone_id" {
  description = "Route53 hosted zone ID"
  value       = aws_route53_zone.stanley_bank_zone.zone_id
}

output "route53_name_servers" {
  description = "NS records — set these in Namecheap"
  value       = aws_route53_zone.stanley_bank_zone.name_servers
}

output "acm_certificate_arn" {
  description = "ACM cert ARN for *.stanleybank.site"
  value       = aws_acm_certificate.stanley_bank_cert.arn
}
