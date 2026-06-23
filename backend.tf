terraform {
  backend "s3" {
    bucket         = "stanley-bank-s3-178220402760-us-east-2-an"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "stanley-bank-tf-lock"
    encrypt        = true
  }

  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}



 # DynamoDB table for state locking.
    # Create it once with:
    #   aws dynamodb create-table \
    #     --table-name stanley-bank-tf-lock \
    #     --attribute-definitions AttributeName=LockID,AttributeType=S \
    #     --key-schema AttributeName=LockID,KeyType=HASH \
    #     --billing-mode PAY_PER_REQUEST \
    #     --region us-east-2