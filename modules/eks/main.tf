module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_groups = {
    general = {
      min_size     = 1
      max_size     = 3
      desired_capacity = 2
      instance_types = ["t3.medium"]
    }
  }
}
