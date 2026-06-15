variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "alb_sg_id" {
  description = "Security Group ID for the ALB"
  type        = string
  default     = "sg-placeholder"
}

variable "create_elastic_ip" {
  description = "Whether to create an elastic IP"
  type        = bool
  default     = true
}

variable "countsub" {
  description = "Number of elastic IPs to create"
  type        = number
  default     = 1
}
