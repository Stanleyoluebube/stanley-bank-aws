variable "region" {
  type    = string
  default = "us-east-2"
}

variable "domain_name" {
  type    = string
  default = "stanleybank.site"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "cluster_name" {
  type    = string
  default = "stanley-bank-eks"
}
