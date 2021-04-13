resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2-allow-assume-role.name
}

resource "aws_iam_role" "ec2-allow-assume-role" {
  name = "ec2-allow-assume-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "lohika-aws-course"
  }
}

data "aws_iam_policy_document" "s3-access" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.s3-bucket.arn]
  }
  statement {
    effect = "Allow"
    actions   = ["s3:GetObject", "s3:GetObjectVersion"]
    resources = ["${aws_s3_bucket.s3-bucket.arn}/${aws_s3_bucket_object.s3-file.key}"]
  }
}

resource "aws_iam_policy" "s3-access-policy" {
  name        = "s3-access-policy"
  description = "A policy for giving access to files on S3 instance."

  policy = data.aws_iam_policy_document.s3-access.json

  tags = {
    tag-key = "lohika-aws-course"
  }
}

resource "aws_iam_role_policy_attachment" "ec2-s3-attach" {
  role       = aws_iam_role.ec2-allow-assume-role.name
  policy_arn = aws_iam_policy.s3-access-policy.arn
}