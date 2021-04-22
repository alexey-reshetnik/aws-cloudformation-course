resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = local.common_tags
}

data "aws_iam_policy_document" "s3_access_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.s3_bucket.arn]
  }
  statement {
    effect = "Allow"
    actions   = ["s3:GetObject", "s3:GetObjectVersion"]
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/${aws_s3_bucket_object.dynamodb_script.key}",
      "${aws_s3_bucket.s3_bucket.arn}/${aws_s3_bucket_object.rds_script.key}",
    ]
  }
}

resource "aws_iam_policy" "s3_access" {
  name        = "s3-access-policy"
  description = "A policy for giving access to files on S3 instance."

  policy = data.aws_iam_policy_document.s3_access_policy.json

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "ec2_s3_attachment" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}
