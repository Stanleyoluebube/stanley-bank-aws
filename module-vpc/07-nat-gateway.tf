resource "aws_nat_gateway" "nat" {
  count         = 2
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "stanley-bank-nat-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.stanley_bank_igw]
}
