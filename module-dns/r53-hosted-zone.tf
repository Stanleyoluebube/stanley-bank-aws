resource "aws_route53_zone" "stanley_bank_zone" {
  name = var.domain_name

  tags = {
    Name = var.domain_name
  }
}
