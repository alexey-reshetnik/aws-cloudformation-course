resource "aws_instance" "db_bastion" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.ec2_instance_type

  key_name = var.ec2_ssh_key_pair_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  user_data = filebase64("${path.module}/${var.ec2_startup_script_path}")
  iam_instance_profile = aws_iam_instance_profile.bastion_iam.name

  tags = local.common_tags
}

resource "aws_iam_instance_profile" "bastion_iam" {
  name = "bastion_iam"
  role = aws_iam_role.bastion_role.name
}

resource "aws_iam_role" "bastion_role" {
  name = "bastion_role"

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

  tags = local.common_tags
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Allow http and ssh traffic for bastion EC2 instance."
  vpc_id      = var.vpc_id

  ingress {
    description       = "allow access to port 80"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  ingress {
    description       = "allow ssh traffic to port 22"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
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

