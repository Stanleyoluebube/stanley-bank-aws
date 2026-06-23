resource "aws_route_table" "public" {
  vpc_id = aws_vpc.stanley_bank_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.stanley_bank_igw.id
  }

  tags = {
    Name = "stanley-bank-public-rt"
  }
}
