# apigw_lambda_tf
API Gateway, Lambda, Swagger and Terraform Demonstration.

1 September, 2019

There are already many examples, blog posts, etc. which illustrate how to use  AWS API Gateway and Lambda with swagger and terraform.  Here is a (hopefully) reproducible example which demonstrates how APIGW/Lambda might help you.

## Lambda

1. Simple python lambda

## API Gateway

1. I wanted API GW to perform as much sanity checking as possible, i.e. use RequestValidator, Request Body, etc.

## Swagger

1. The swagger file contains x-amazon-apigateway statements as needed.

## Terraform

1. Developed using terraform v0.12.6

## How to deploy

1. Create a (private) S3 bucket to contain lambda artifacts
    1. update variables.tf (lambda_bucket) w/bucket name
1. upload the lambda function to S3
    1. s3_upload.sh can help
    1. verify lambda deployment
        1. aws lambda invoke --function-name ping_handler output.txt 
1. variables.tf must be updated for your AWS account
1. terraform init;terraform apply should deploy to AWS

## How to remove

1. terraform destroy will delete API GW and lambda
1. You must delete the S3 (lambda artifact) bucket manually.

## Operation

1. Use the AWS web console, navigate to API Gatewway.  You should see PingGateway has been deployed.
1. Click through PingGateway
    1. Click through Stages
    1. Expand "v01"
    1. Click on the top "GET" (static HTML example)
    1. Click on the "Invoke URL"
        1. Should render "responseTemplate"
    1. Click on /ping/POST
        1. Copy "Invoke URL" string to "ping1.sh"