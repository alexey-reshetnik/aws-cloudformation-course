Week 3

Useful commands

SSH command to connect to the EC2 bastion:

ssh -i "../ssh_key_default.pem" ec2-user@instance_endpoint

To check if EC2 is able to connect to RDS db:

telnet instance_endpoint 5432

PostgreSQL connection string:

psql \
--host=<instance_endpoint> \
--username=<master_username> \
--dbname=postgres \
--file=rds.sql

IAM credentials retrieval:

example value lohika-course.cwlrd4c3mqxn.us-west-2.rds.amazonaws.com
export RDSHOST="instance_endpoint"

export PGPASSWORD="$(aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region us-west-2 --username postgres)"


psql \
--host=$RDSHOST \
--username=postgres \
--dbname=postgres \
--file=rds.sql

bastion_address = "ec2-34-215-13-160.us-west-2.compute.amazonaws.com"
db_address = "lohika-course.cwlrd4c3mqxn.us-west-2.rds.amazonaws.com:5432"
