resource "aws_dynamodb_table" "dynamodb" {
  name             = var.dynamo_db_name

  hash_key = "CourseUser"
  attribute {
    name = "CourseUser"
    type = "N"
  }

  read_capacity  = 10
  write_capacity = 10

  tags = local.common_tags

}