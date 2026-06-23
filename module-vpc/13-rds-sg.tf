resource "aws_security_group" "rds_sg" {
  name        = "stanley-bank-rds-sg"
  description = "Allow inbound Postgres from EKS nodes"
  vpc_id      = aws_vpc.stanley_bank_vpc.id

  ingress {
    description = "Postgres from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "stanley-bank-rds-sg"
  }
}
