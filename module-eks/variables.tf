variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs"
}

variable "node_instance_type" {
  type        = string
  description = "Instance type for nodes"
}

variable "node_disk_size" {
  type        = number
  description = "Disk size (GiB)"
}

variable "node_desired_size" {
  type        = number
  description = "Desired node count"
}

variable "node_min_size" {
  type        = number
  description = "Min node count"
}

variable "node_max_size" {
  type        = number
  description = "Max node count"
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "EKS API public endpoint"
}

variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to access EKS API"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "EKS API private endpoint"
}
