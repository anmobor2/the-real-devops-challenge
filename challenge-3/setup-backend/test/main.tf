# provider "aws" {
#   region                      = "eu-north-1"
#   access_key                  = "test"
#   secret_key                  = "test"
#   skip_credentials_validation = true
#   skip_requesting_account_id  = true

#   default_tags {
#     tags = {
#       Environment = "LocalStack"
#     }
#   }

# #  default_alias = "localstack"

#   endpoints {
#        dynamodb = "http://localhost:4566"
#         s3 = "http://localhost:4566"
#   }
# }



provider "aws" {
  region = "eu-north-1"
}

data "aws_iam_policy_document" "terraform_state_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::terraform-state-bucket",
      "arn:aws:s3:::terraform-state-bucket/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/terraform-state-lock"
    ]
  }
}

resource "aws_iam_policy" "terraform_state_policy" {
  name   = "TerraformStatePolicy"
  policy = data.aws_iam_policy_document.terraform_state_policy.json
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "terraform_state_role" {
  name = "TerraformStateRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "terraform_state_role_policy_attachment" {
  role       = aws_iam_role.terraform_state_role.name
  policy_arn = aws_iam_policy.terraform_state_policy.arn
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket        = "terraform-state-bucket-unique-id-toni"
  force_destroy = true
  tags = {
    Name = "Terraform State Bucket"
  }

  depends_on = [
    aws_iam_role_policy_attachment.terraform_state_role_policy_attachment,
    aws_dynamodb_table.terraform_state_lock
  ]

  lifecycle {
    ignore_changes = [
      bucket,
    ]
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}