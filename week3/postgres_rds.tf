resource "aws_db_instance" "rds_postgres" {
  engine               = "postgres"

  identifier = var.postgres_db_name
  allocated_storage    = var.postgres_storage_size
  instance_class       = var.postgres_instance_type

  username             = var.postgres_root_username
  password             = var.postgres_root_password
  skip_final_snapshot  = true
  delete_automated_backups = true
  iam_database_authentication_enabled = true

  vpc_security_group_ids = [aws_security_group.postgres_sg.id]

  tags = local.common_tags
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "rds_connect_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions   = ["rds-db:connect"]
    resources = [
      "arn:aws:rds-db:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_db_instance.rds_postgres.resource_id}/${var.postgres_iam_username}"
    ]
  }
}

resource "aws_iam_policy" "rds_connect" {
  name        = "rds_connect"
  description = "A policy for allowing connection to rds"

  policy = data.aws_iam_policy_document.rds_connect_policy.json

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "ec2_rds_connect" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = aws_iam_policy.rds_connect.arn
}

resource "aws_security_group" "postgres_sg" {
  name        = "postgres_sg"
  description = "Allow traffic to database from instances in security group"
  vpc_id      = var.vpc_id

  ingress {
    description       = "allow all traffic from bastion instance"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    description       = "allow all egress traffic"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

// https://aws.amazon.com/premiumsupport/knowledge-center/rds-postgresql-connect-using-iam/
// https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.IAMPolicy.html

// here i tried to create an postgres role for logging in using IAM.
// Deprecated due to inability to connect to db from local machine

//terraform {
//  required_providers {
//    postgresql = {
//      source = "cyrilgdn/postgresql"
//      version = "1.12.0"
//    }
//  }
//}

//provider "postgresql" {
//  alias = "rds"
//  username = var.postgres_root_username
//  password = var.postgres_root_password
//
//  scheme   = "awspostgres"
//  host     = aws_db_instance.rds_postgres.address
//  port     = aws_db_instance.rds_postgres.port
//
//  sslmode = "disable"
//  superuser = false
//}
//
//resource "postgresql_role" "iam_role" {
//  provider = postgresql.rds
//  login            = true
//  name             = var.postgres_root_username
//  password         = var.postgres_root_password
//  roles = ["rds_iam"]
//}
