module "vpc" {
  source = "./modules/vpc"
}

module "database" {
  source      = "./modules/database"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnets
  db_password = var.db_password
}

module "eks" {
  source     = "./modules/eks"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_name = var.cluster_name
}

module "dns" {
  source      = "./modules/dns"
  domain_name = var.domain_name
}

module "runner" {
  source         = "./modules/runner"
  vpc_id        = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}
