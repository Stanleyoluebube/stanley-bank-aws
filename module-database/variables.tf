variable "vpc_id" {
  type        = string
  description = "VPC ID (for tagging, not direct use)"
}

variable "db_subnet_ids" {
  type        = list(string)
  description = "DB subnet IDs"
}

variable "db_security_group_id" {
  type        = string
  description = "Security group ID for RDS"
}

variable "db_instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "db_allocated_storage" {
  type        = number
  description = "Allocated storage (GiB)"
}

variable "db_engine_version" {
  type        = string
  description = "Postgres engine version"
}

variable "db_username" {
  type        = string
  description = "Master username"
}

variable "db_password" {
  type        = string
  description = "Master password"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "Initial database name"
}

variable "db_multi_az" {
  type        = bool
  description = "Enable multi-AZ"
}
