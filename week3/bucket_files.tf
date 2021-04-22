resource "aws_s3_bucket_object" "dynamodb_script" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "dynamodb.sh"
  source = "${path.module}/${var.s3_dynamodb_script}"

  tags = local.common_tags
}

resource "aws_s3_bucket_object" "rds_script" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "rds.sql"
  source = "${path.module}/${var.s3_rds_script}"

  tags = local.common_tags
}