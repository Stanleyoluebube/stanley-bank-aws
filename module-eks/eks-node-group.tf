resource "aws_eks_node_group" "stanley_bank" {
  cluster_name    = aws_eks_cluster.stanley_bank.name
  node_group_name = "stanley-bank-ng"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.private_subnet_ids

  # Per project spec
  instance_types = [var.node_instance_type]   # t3.large
  disk_size      = var.node_disk_size          # 40 GiB
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = var.node_desired_size  # 3
    min_size     = var.node_min_size      # 2
    max_size     = var.node_max_size      # 6
  }

  update_config {
    max_unavailable = 1
  }

  # Use the EKS-optimised AMI for Kubernetes 1.30
  ami_type = "AL2023_x86_64_STANDARD"

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only,
  ]

  tags = {
    Name = "stanley-bank-node"
  }
}
