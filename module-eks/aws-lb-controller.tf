###############################################################################
# AWS Load Balancer Controller — IRSA + Helm chart
# (This controller is what makes the `alb` ingressClassName work.)
###############################################################################

data "aws_iam_policy_document" "aws_lb_controller_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${aws_iam_openid_connect_provider.eks.url}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }
  }
}

resource "aws_iam_role" "aws_lb_controller" {
  name               = "stanley-bank-aws-lb-controller-role"
  assume_role_policy = data.aws_iam_policy_document.aws_lb_controller_assume_role.json
}

# The controller needs a fairly broad policy. Easiest path: attach the
# AWS-managed policy shipped with the controller. You can replace this
# with a more restrictive inline policy if you prefer.
resource "aws_iam_role_policy_attachment" "aws_lb_controller" {
  role       = aws_iam_role.aws_lb_controller.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/AWSLoadBalancerControllerIAMPolicy"
}

resource "kubernetes_service_account" "aws_lb_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws_lb_controller.arn
    }
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.7.1"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.stanley_bank.name
  }

  # Pass the VPC ID explicitly — the controller's auto-detection from
  # EC2 instance metadata fails because EKS node IMDS is v2-only and
  # the controller is making v1 requests (returns 401).
  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }
  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account.aws_lb_controller.metadata[0].name
  }

  depends_on = [
    kubernetes_service_account.aws_lb_controller,
    helm_release.aws_ebs_csi_driver,
  ]
}