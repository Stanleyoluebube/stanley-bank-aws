resource "aws_iam_role" "runner" {
  name = "stanley-bank-runner-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "runner_full_access" {
  role       = aws_iam_role.runner.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "runner_profile" {
  name = "stanley-bank-runner-profile"
  role = aws_iam_role.runner.name
}

resource "aws_instance" "runner" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  subnet_id     = var.public_subnets[0]
  iam_instance_profile = aws_iam_instance_profile.runner_profile.name

  tags = { Name = "stanley-bank-ci-runner" }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"] # Use amazon or canonical (Canonical's ID is different)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
