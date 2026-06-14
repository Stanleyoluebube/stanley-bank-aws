resource "aws_route53_record" "ns" {
  count   = 4
  zone_id = aws_route53_zone.main.zone_id
  name    = "ns${count.index + 1}.stanleybank.com"
  type    = "A"
  ttl     = "300"
  records = ["TBD_NAMECHEAP_IP"]
}
