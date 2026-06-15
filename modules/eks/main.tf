module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"
  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  cluster_addons = {
    vpc-cni = {
      cluster_class = "ONDemand"
    }
    kube-proxy = {
      cluster_class = "ONDemand"
    }
    coredns = {
      cluster_class = "ONDemand"
    }
  }

  vpc_id     = var.vpc_id

  subnet_ids = var.subnet_ids

  eks_managed_node_groups = {
    main_nodes = {
      min_size     = 1
      max_size     = 3
      desired_capacity = 2
      instance_types = ["t3.medium"]
      labels = {
        role = "worker"
      }
    }
  }
}
