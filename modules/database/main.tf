module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"


  identifier = "stanley-bank-db"
  engine            = "postgres"
  engine_version    = "15"
  family            = "postgres15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name           = "stanleybankdb"
  username          = "stanleyadmin"
  password          = var.db_password

  vpc_security_group_ids = [module.rds_sg.security_group_id]
  subnet_ids             = var.subnet_ids
  create_db_subnet_group = true
}

module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name   = "rds-sg"
  vpc_id = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      type        = "ingress"
      protocol    = "tcp"
      description = "PostgreSQL from VPC"
      cidr_blocks = var.vpc_cidr
    },
  ]
}
