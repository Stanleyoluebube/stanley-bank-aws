resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.stanley_bank_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name                                     = "stanley-bank-public-${var.availability_zones[count.index]}"
    "kubernetes.io/role/elb"                 = "1"
    "kubernetes.io/cluster/stanley-bank-eks" = "owned"
  }
}
