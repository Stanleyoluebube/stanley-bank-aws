resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = { Name = "stanley-bank-private-${count.index}" }
}
