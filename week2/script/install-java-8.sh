#!/bin/bash
yum -y install java-1.8.0-openjdk
java -version > ./java-output.txt

aws s3 cp s3://lohika-course-reshetnik/hello.txt /home/ec2-user/hello.txt
