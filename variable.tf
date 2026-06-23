# Root-level variables. Module variables live inside each module.

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-2"
}

variable "domain_name" {
  type        = string
  description = "Primary domain name (e.g. stanleybank.site)"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = "stanley-bank-eks"
}

# --- VPC ---------------------------------------------------------------------

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the public subnets (one per AZ)"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the private subnets (one per AZ)"
}

variable "db_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the DB subnets (private, for RDS)"
}

variable "availability_zones" {
  type        = list(string)
  description = "AZs to spread subnets across"
}

# --- EKS node group ----------------------------------------------------------

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type for the EKS node group"
  default     = "t3.large"
}

variable "node_disk_size" {
  type        = number
  description = "Disk size (GiB) for each node"
  default     = 40
}

variable "node_desired_size" {
  type        = number
  description = "Desired number of nodes"
  default     = 3
}

variable "node_min_size" {
  type        = number
  description = "Minimum number of nodes"
  default     = 2
}

variable "node_max_size" {
  type        = number
  description = "Maximum number of nodes"
  default     = 6
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Whether the EKS API endpoint is publicly reachable"
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to reach the EKS public API endpoint"
  default     = ["0.0.0.0/0"]
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Whether the EKS API endpoint is reachable from inside the VPC"
  default     = true
}

# --- RDS ---------------------------------------------------------------------

variable "db_instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.t3.medium"
}

variable "db_allocated_storage" {
  type        = number
  description = "RDS allocated storage (GiB)"
  default     = 40
}

variable "db_engine_version" {
  type        = string
  description = "PostgreSQL engine version"
  default     = "16.3"
}

variable "db_username" {
  type        = string
  description = "Master username for RDS"
  default     = "stanleyadmin"
}

variable "db_password" {
  type        = string
  description = "Master password for RDS (sensitive — use TF_VAR_db_password in CI)"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "Initial database name"
  default     = "stanleybankdb"
}

variable "db_multi_az" {
  type        = bool
  description = "Enable multi-AZ for RDS"
  default     = true
}
