# DNS alias records for app.stanleybank.site, api.stanleybank.site, and
# argocd.stanleybank.site are intentionally NOT created here.
#
# The NLB/ALB DNS names are created asynchronously by the ingress
# controllers (ingress-nginx, AWS Load Balancer Controller) inside the
# cluster after ingresses are applied. Terraform cannot reference them
# at apply time.
#
# After the first terraform apply succeeds and the ingresses have been
# created, create the alias records manually — see
# stanley-bank-k8s/README.md "Route53 alias records (after the first
# apply)" section.