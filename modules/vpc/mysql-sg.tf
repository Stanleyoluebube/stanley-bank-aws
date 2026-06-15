resource "aws_security_group" "mysql_sg" {
  name        = "stanley-bank-mysql-sg"
  description = "Allow MySQL traffic from EKS nodes"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "stanley-bank-mysql-sg" }
}
