#!/bin/bash

aws dynamodb list-tables --region us-west-2

aws dynamodb put-item --table-name "lohika-course-documents" --item '{"CourseUser": { "N": "1" }, "value": { "S": "Alex Reshetnyk" } }' --region us-west-2
aws dynamodb put-item --table-name "lohika-course-documents" --item '{"CourseUser": { "N": "2" }, "value": { "S": "Test User" } }' --region us-west-2

aws dynamodb get-item --table-name "lohika-course-documents" --key '{ "CourseUser": { "N": "1" } }' --region us-west-2
aws dynamodb get-item --table-name "lohika-course-documents" --key '{ "CourseUser": { "N": "2" } }' --region us-west-2
