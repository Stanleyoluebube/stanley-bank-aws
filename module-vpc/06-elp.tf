resource "aws_eip" "nat" {
  count  = 2
  domain = "vpc"

  tags = {
    Name = "stanley-bank-nat-eip-${count.index + 1}"
  }
}
