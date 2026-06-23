resource "aws_vpc" "stanley_bank_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "stanley-bank-vpc"
  }
}
