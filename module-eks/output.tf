output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.stanley_bank.name
}

output "cluster_endpoint" {
  description = "EKS API endpoint"
  value       = aws_eks_cluster.stanley_bank.endpoint
}

output "cluster_ca_certificate" {
  description = "EKS CA cert (base64)"
  value       = aws_eks_cluster.stanley_bank.certificate_authority[0].data
}

output "cluster_oidc_issuer_url" {
  description = "EKS OIDC issuer URL"
  value       = aws_eks_cluster.stanley_bank.identity[0].oidc[0].issuer
}

output "ecr_frontend_repository_url" {
  description = "ECR URL for frontend"
  value       = aws_ecr_repository.frontend.repository_url
}

output "ecr_backend_repository_url" {
  description = "ECR URL for backend"
  value       = aws_ecr_repository.backend.repository_url
}

output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = "argocd"
}