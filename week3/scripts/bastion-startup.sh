#!/bin/bash
yum -y install postgresql
yum -y install telnet

aws s3 cp s3://lohika-course-reshetnik/dynamodb.sh /home/ec2-user/dynamodb.sh
aws s3 cp s3://lohika-course-reshetnik/rds.sql /home/ec2-user/rds.sql
