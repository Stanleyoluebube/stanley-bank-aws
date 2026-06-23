resource "aws_ecr_repository" "frontend" {
  name                 = "stanleybank/app"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "stanleybank/app"
  }
}

resource "aws_ecr_repository" "backend" {
  name                 = "stanleybank/server"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "stanleybank/server"
  }
}
