###############################################################################
# Outputs
###############################################################################

# --- EKS ---------------------------------------------------------------------
output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
  description = "EKS CA certificate (base64)"
  value       = module.eks.cluster_ca_certificate
  sensitive   = true
}

output "kubeconfig_command" {
  description = "Run this to write a kubeconfig for the cluster"
  value       = "aws eks update-kubeconfig --region us-east-2 --name ${module.eks.cluster_name}"
}

# --- ECR ---------------------------------------------------------------------
output "ecr_backend_repository_url" {
  description = "ECR repository URL for the backend"
  value       = module.eks.ecr_backend_repository_url
}

output "ecr_frontend_repository_url" {
  description = "ECR repository URL for the frontend"
  value       = module.eks.ecr_frontend_repository_url
}

# --- RDS ---------------------------------------------------------------------
output "rds_endpoint" {
  description = "RDS endpoint (host:port)"
  value       = module.database.rds_endpoint
  sensitive   = true
}

output "rds_host" {
  description = "RDS host (just the hostname)"
  value       = module.database.rds_host
}

# --- DNS / ACM ---------------------------------------------------------------
output "route53_name_servers" {
  description = "NS records to set in Namecheap for stanleybank.site"
  value       = module.dns.route53_name_servers
}

output "acm_certificate_arn" {
  description = "ACM cert ARN — paste into frontend/backend ingresses"
  value       = module.dns.acm_certificate_arn
}

# --- VPC ---------------------------------------------------------------------
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

# --- ArgoCD ------------------------------------------------------------------
output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = module.eks.argocd_namespace
}

output "argocd_initial_password" {
  description = "Initial ArgoCD admin password (bcrypt hash in secret argocd-initial-admin-secret)"
  value       = "Run: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}
