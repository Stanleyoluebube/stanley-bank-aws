resource "aws_security_group" "eks_cluster_sg" {
  name        = "stanley-bank-eks-cluster-sg"
  description = "Cluster security group"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "stanley-bank-eks-cluster-sg"
  }
}

resource "aws_eks_cluster" "stanley_bank" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.30"

  vpc_config {
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)

    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller,
  ]

  tags = {
    Name = var.cluster_name
  }
}

# OIDC provider for IRSA (IAM Roles for Service Accounts)
data "tls_certificate" "eks_oidc" {
  url = aws_eks_cluster.stanley_bank.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
  thumbprint_list = [data.tls_certificate.eks_oidc.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.stanley_bank.identity[0].oidc[0].issuer
  tags = {
    Name = "${var.cluster_name}-irsa"
  }
}
