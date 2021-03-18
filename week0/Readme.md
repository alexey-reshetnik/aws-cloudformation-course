## Week 0

Cloudformation script for single EC2 instance.

##### Inputs:
 - AMI (default: latest image id from store)
 - instance type (default: t2.micro), can be one of [t2.nano, t2.micro]
 - key name which will allow SSH access to deployed instance

##### Returns:
 - id of created instance
 - dns name of instance
 - public IP address

###### Command for creating AWS stack from given template:

aws cloudformation create-stack --stack-name weekZeroDefaultParams --template-body file://ec2.yaml

###### Command for validating created template for syntax errors:

aws cloudformation validate-template --template-body file://ec2.yaml

###### Command for checking stack deployment status:

aws cloudformation describe-stack-events --stack-name weekZeroDefaultParams

###### Command for removing stack entirely:

aws cloudformation delete-stack --stack-name weekZeroDefaultParams 