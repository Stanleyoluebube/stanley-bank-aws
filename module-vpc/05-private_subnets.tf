# resource "aws_subnet" "private" {
#   count             = length(var.private_subnet_cidrs)
#   vpc_id            = aws_vpc.stanley_bank_vpc.id
#   cidr_block        = var.private_subnet_cidrs[count.index]
#   availability_zone = var.availability_zones[count.index]

#   tags = {
#     Name = "stanley-bank-private-${var.availability_zones[count.index]}"
#   }
# }




resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.stanley_bank_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name                                     = "stanley-bank-private-${var.availability_zones[count.index]}"
    Environment                              = "production"
    Project                                  = "stanley-bank"
    ManagedBy                                = "terraform"
    "kubernetes.io/role/internal-elb"        = "1"
    "kubernetes.io/cluster/stanley-bank-eks" = "owned"
  }
}