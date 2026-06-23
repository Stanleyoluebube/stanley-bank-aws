provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "stanley-bank"
      Environment = "production"
      ManagedBy   = "terraform"
    }
  }
}