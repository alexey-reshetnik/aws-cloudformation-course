resource "aws_s3_bucket" "s3-bucket" {
  bucket = "lohika-course-reshetnik"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name = "lohika-aws-course"
  }
}

resource "aws_s3_bucket_object" "s3-file" {
  bucket = aws_s3_bucket.s3-bucket.bucket
  key    = "hello.txt"
  source = "resource/hello.txt"

  tags = {
    Name = "lohika-aws-course"
  }
}
