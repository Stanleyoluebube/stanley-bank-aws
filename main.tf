###############################################################################
# Stanley Bank — root Terraform configuration
#
# Order of operations:
#   1. VPC + subnets + NAT
#   2. EKS cluster + node group + add-ons (incl. ALB controller, ArgoCD)
#   3. RDS Postgres
#   4. Route53 hosted zone + ACM cert for stanleybank.site
###############################################################################

# --- 1. VPC ------------------------------------------------------------------
module "vpc" {
  source = "./module-vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  db_subnet_cidrs      = var.db_subnet_cidrs
  availability_zones   = var.availability_zones
}

# --- 2. EKS ------------------------------------------------------------------
module "eks" {
  source = "./module-eks"

  cluster_name = var.cluster_name

  vpc_id                  = module.vpc.vpc_id
  public_subnet_ids       = module.vpc.public_subnet_ids
  private_subnet_ids      = module.vpc.private_subnet_ids

  node_instance_type      = var.node_instance_type
  node_disk_size          = var.node_disk_size
  node_desired_size       = var.node_desired_size
  node_min_size           = var.node_min_size
  node_max_size           = var.node_max_size

  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
}

# --- 3. RDS Postgres ---------------------------------------------------------
module "database" {
  source = "./module-database"

  vpc_id             = module.vpc.vpc_id
  db_subnet_ids      = module.vpc.db_subnet_ids
  db_security_group_id = module.vpc.db_security_group_id

  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_engine_version    = var.db_engine_version
  db_username          = var.db_username
  db_password          = var.db_password
  db_name              = var.db_name
  db_multi_az          = var.db_multi_az
}

# --- 4. DNS + ACM ------------------------------------------------------------
module "dns" {
  source = "./module-dns"

  domain_name = var.domain_name
}
