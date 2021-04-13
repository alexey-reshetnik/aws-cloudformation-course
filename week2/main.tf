terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "lohika-root"
  region  = "us-west-2"
}

resource "aws_launch_template" "ec2-template" {
  name = "lohika-ec2-template"

  image_id = "ami-0518bb0e75d3619ca"
  instance_type = "t2.micro"
  key_name = "ssh_key_default"
  vpc_security_group_ids = [aws_security_group.access-http-ssh.id]
  user_data = filebase64("${path.module}/script/install-java-8.sh")
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2-instance-profile.name
  }

  tags = {
    Name = "lohika-aws-course"
  }
}

resource "aws_autoscaling_group" "ec2-asg" {
  availability_zones = ["us-west-2a"]
  desired_capacity   = 2
  min_size           = 2
  max_size           = 4

  launch_template {
    id      = aws_launch_template.ec2-template.id
    version = "$Latest"
  }

  tag {
    key                 = "lohika-aws-course"
    value               = ""
    propagate_at_launch = true
  }
}
