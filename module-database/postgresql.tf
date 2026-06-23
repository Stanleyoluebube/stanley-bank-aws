resource "aws_db_subnet_group" "stanley_bank_db" {
  name       = "stanley-bank-db-subnets"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "stanley-bank-db-subnet-group"
  }
}

resource "aws_db_instance" "stanley_bank_db" {
  identifier     = "stanley-bank-db"
  engine         = "postgres"
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = 0  # disable storage autoscaling
  storage_type          = "gp3"

  username = var.db_username
  password = var.db_password
  db_name  = var.db_name

  db_subnet_group_name   = aws_db_subnet_group.stanley_bank_db.name
  vpc_security_group_ids = [var.db_security_group_id]

  multi_az              = var.db_multi_az
  publicly_accessible   = false
  storage_encrypted     = true
  skip_final_snapshot   = true
  deletion_protection   = false  # set true once everything is stable

  backup_retention_period = 7
  backup_window           = "07:00-09:00"
  maintenance_window      = "sun:09:30-sun:10:30"

  tags = {
    Name = "stanley-bank-db"
  }
}
