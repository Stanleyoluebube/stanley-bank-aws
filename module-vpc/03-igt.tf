resource "aws_internet_gateway" "stanley_bank_igw" {
  vpc_id = aws_vpc.stanley_bank_vpc.id

  tags = {
    Name = "stanley-bank-igw"
  }
}
