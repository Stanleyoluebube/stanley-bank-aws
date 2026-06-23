data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

locals {
  name = "stanley-bank-eks"

  # The trust policy for the cluster IAM role is built dynamically
  # against the EKS service principal for the current partition.
  cluster_role_trust = {
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.${data.aws_partition.current.dns_suffix}"
      }
      Action = "sts:AssumeRole"
    }]
  }
}
