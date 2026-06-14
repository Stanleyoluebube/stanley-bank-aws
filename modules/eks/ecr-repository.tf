resource "aws_ecr_repository" "frontend" {
  name = "stanley-bank-frontend"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "backend" {
  name = "stanley-bank-backend"
  image_scanning_configuration {
    scan_on_push = true
  }
}
