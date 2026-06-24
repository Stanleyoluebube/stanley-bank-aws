###############################################################################
# cert-manager — for Let's Encrypt ACME certificates
###############################################################################

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  version          = "v1.15.0"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

###############################################################################
# ingress-nginx — controller for the nginx ingressClassName
# (used by ArgoCD and cert-manager http01 challenges)
###############################################################################

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  version          = "4.15.1"

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

  depends_on = [helm_release.cert_manager]
}

###############################################################################
# ArgoCD — installed by Terraform so the cluster is bootstrapped.
# The repo's manifests are then synced via ArgoCD itself (GitOps).
###############################################################################

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "7.6.12"

  values = [
    file("${path.module}/argocd-values.yaml"),
  ]

  depends_on = [
    helm_release.cert_manager,
    helm_release.ingress_nginx,
  ]
}