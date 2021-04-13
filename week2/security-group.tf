resource "aws_security_group" "access-http-ssh" {
  name        = "access-http-ssh"
  description = "Allow http and ssh traffic"
  vpc_id      = "vpc-4c7a5c34"

  tags = {
    Name = "lohika-aws-course"
  }
}

resource "aws_security_group_rule" "ingress-http" {
  type              = "ingress"
  description       = "allow access to port 80"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.access-http-ssh.id
}

resource "aws_security_group_rule" "ingress-ssh" {
  type              = "ingress"
  description       = "allow ssh traffic to port 22"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.access-http-ssh.id
}

resource "aws_security_group_rule" "egress-all" {
  type              = "egress"
  description       = "allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.access-http-ssh.id
}