# Stanley Bank — Terraform infrastructure

Provisions the entire AWS estate: VPC, EKS, RDS, ECR, Route53, ArgoCD.

## One-time prerequisites

1. **DynamoDB table for state locking** (the S3 bucket already exists):
   ```sh
   aws dynamodb create-table \
     --table-name stanley-bank-tf-lock \
     --attribute-definitions AttributeName=LockID,AttributeType=S \
     --key-schema AttributeName=LockID,KeyType=HASH \
     --billing-mode PAY_PER_REQUEST \
     --region us-east-2
   ```

2. **GitHub repo vars/secrets** (see CI/CD below).

3. **Namecheap nameserver update** — after first `terraform apply`, the
   `route53_name_servers` output gives the 4 NS records to paste into
   Namecheap's "Custom DNS" for `stanleybank.site`.

## Quick start

```sh
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

The first apply takes ~15–20 minutes (EKS + node group bootstrapping is
slow).

## CI/CD

`.github/workflows/ci-cd.yaml` runs `terraform plan` on every push to `main`.
Apply is **manual** via `workflow_dispatch` to avoid auto-apply of infra.

### Required GitHub repo vars (stanley-bank-aws repo)
- `AWS_REGION` = `us-east-2`
- `TF_VERSION` = `1.9.5`

### Required GitHub repo secrets
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## Layout

```
01-provider.tf           AWS provider + default_tags
backend.tf               S3 + DynamoDB state backend
main.tf                  Module wiring (vpc → eks → database → dns)
output.tf                Cluster, RDS, ECR, ACM, Route53 outputs
variable.tf              All input variables
terraform.tfvars         Concrete values for this environment

module-vpc/              02-vpc.tf … 13-rds-sg.tf + variables.tf + output.tf
module-eks/              Cluster, node group, IRSA, ALB controller,
                         cert-manager, ingress-nginx, ArgoCD
module-database/         RDS Postgres (multi-AZ)
module-dns/              Route53 zone + ACM cert + alias records
```

## After the first apply

```sh
# Configure kubectl
aws eks update-kubeconfig --region us-east-2 --name stanley-bank-eks

# Apply the ClusterIssuer (one-time)
kubectl apply -f ../stanley-bank-k8s/bank-project/cluster-issuer.yaml

# Apply the ArgoCD ingress
kubectl apply -f ../stanley-bank-k8s/bank-project/argocd-namespace.yaml
kubectl apply -f ../stanley-bank-k8s/bank-project/ingress-argocd.yaml

# Get the ArgoCD initial admin password
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d

# Bootstrap ArgoCD (one-time)
kubectl apply -f ../stanley-bank-k8s/bank-project/argocd-app.yaml
```

## Replacing placeholder image tags

The `frontend-deployment.yaml` and `backend-deployment.yaml` in
`stanley-bank-k8s` ship with `image: REPLACE_WITH_ECR_IMAGE`. The first
push to `main` in either app repo will replace this with a real image
tag via GitHub Actions. Until then, the deployments will fail their
image-pull — that's expected.