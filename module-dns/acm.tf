resource "aws_acm_certificate" "stanley_bank_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.domain_name}",
  ]

  tags = {
    Name = "stanley-bank-cert"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# DNS validation records — created by ACM itself, but we attach them
# to the hosted zone so Let's Encrypt can verify ownership.
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.stanley_bank_cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.stanley_bank_zone.zone_id
}

resource "aws_acm_certificate_validation" "stanley_bank_cert" {
  certificate_arn         = aws_acm_certificate.stanley_bank_cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}
