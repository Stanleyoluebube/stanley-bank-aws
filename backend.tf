terraform {
  backend "s3" {
    bucket = "stanley-bank-s3-178220402760-us-east-2-an"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}
