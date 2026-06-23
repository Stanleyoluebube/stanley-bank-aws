variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs (one per AZ)"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs (one per AZ)"
}

variable "db_subnet_cidrs" {
  type        = list(string)
  description = "DB subnet CIDRs (private)"
}

variable "availability_zones" {
  type        = list(string)
  description = "AZs"
}
