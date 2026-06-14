resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "app.${var.domain_name}"
  type    = "A"
  ttl     = "300"

  records = ["TBD_LOADBALANCER_DNS"]
}
