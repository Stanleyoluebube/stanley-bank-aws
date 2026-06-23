resource "aws_route_table" "private" {
  count  = 2
  vpc_id = aws_vpc.stanley_bank_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "stanley-bank-private-rt-${count.index + 1}"
  }
}
