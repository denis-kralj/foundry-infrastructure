# depends on main.tf

variable "s3_namespace" {
  type = string
}

resource "aws_s3_bucket" "foundry" {
  bucket        = "${var.s3_namespace}-${var.application}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "foundry" {
  bucket = aws_s3_bucket.foundry.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_access_point" "foundry" {
  bucket = aws_s3_bucket.foundry.id
  name   = aws_s3_bucket.foundry.id

  vpc_configuration {
    vpc_id = aws_vpc.main.id
  }

  public_access_block_configuration {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}

# TODO: doesn't do what we want completely, any auth user can go
# into the bucket, not only ones in the relevant VPC
resource "aws_s3control_access_point_policy" "foundry" {
  access_point_arn = aws_s3_access_point.foundry.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "s3:*"
      Principal = {
        AWS = "*"
      }
      Resource = "${aws_s3_access_point.foundry.arn}/object/*"
    }]
  })
}
