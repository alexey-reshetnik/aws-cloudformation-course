variable "project_name" {
  type = string
  default = "lohika-aws-course"
}

variable "vpc_id" {
  type = string
  default = "vpc-4c7a5c34"
}

variable "ec2_instance_type" {
  type = string
  default = "t2.micro"
}

variable "ec2_ssh_key_pair_name" {
  type = string
  default = "ssh_key_default"
}

variable "ec2_startup_script_path" {
  type = string
  default = "scripts/bastion-startup.sh"
}

variable "s3_bucket_name" {
  type = string
  default = "lohika-course-reshetnik"
}

variable "s3_rds_script" {
  type = string
  default = "scripts/rds.sql"
}

variable "s3_dynamodb_script" {
  type = string
  default = "scripts/dynamodb.sh"
}

variable "postgres_instance_type" {
  type = string
  default = "db.t2.micro"
}

variable "postgres_storage_size" {
  type = number
  default = 10
}

variable "postgres_root_username" {
  type = string
  default = "postgres"
}

variable "postgres_root_password" {
  type = string
  default = "baab24b5-1dc2-4c3f-ba47-181055ffc2a7"
}

variable "postgres_iam_username" {
  type = string
  default = "iam_user"
}

variable "postgres_db_name" {
  type = string
  default = "lohika-course"
}

variable "dynamo_db_name" {
  type = string
  default = "lohika-course-documents"
}

locals {
  common_tags = {
    Project = var.project_name
  }
}