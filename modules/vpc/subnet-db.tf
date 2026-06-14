resource "aws_subnet" "db" {
  count             = 2
  vpc_id            = var.vpc_id
  cidr_block        = "192.168.0.0/24" # Simplified for example
  availability_zone = var.azs[count.index]

  tags = {
    Name = "stanley-bank-db-subnet-${count.index}"
    "kubernetes.io/role/internal-elb" = 1
  }
}
