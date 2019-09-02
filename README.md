# apigw_lambda_tf
API Gateway, Lambda, Swagger and Terraform Demonstration.

1 September, 2019

There are already many examples, blog posts, etc. which illustrate how to use  AWS API Gateway and Lambda with swagger and terraform.  Here is a (hopefully) reproducible example which demonstrates how API GW/Lambda might help you.

This example creates an API Gateway which exposes 3 endpoints

verb | stage | endpoint  | lambda       | note
-----|-------|-----------|--------------|--------------------
get  |  v01  | /         | none         | static HTML served by API GW
get  |  v01  | /ping{id} | ping_handler | get a specific ping 
post |  v01  | /ping     | ping_handler | create a fresh ping

## Lambda

1. Simple python lambda "ping_handler".  
    1. Writes to CloudWatch
    1. Deploys to S3

## API Gateway

1. I wanted API GW to perform as much sanity checking as possible, i.e. use RequestValidator, Request Body, etc.  Room for improvement.  API GW returns a HTTP 400 if there is a failure at this stage.  HTTP requests are mapped to model PingRequestV1, responses are mapped to PingResponseV1.

### PingRequestV1 (model)

    {
        preamble: {
          transactionUuid: uuid
          messageVersion: 1
          messageVerb: "GET" or "POST"
          messageType: "PING"
        }
        pingState: boolean
    }

### PingResponseV1 (model)

    {
        preamble: {
          transactionUuid: uuid
          messageVersion: 1
          messageType: "PING"
        }
        pingState: boolean
    }

## Swagger

1. swagger.yaml contains x-amazon-apigateway statements as needed.

## Terraform

1. Developed using terraform v0.12.6
1. Everything you need to modify is in `variables.tf`

## How to deploy

1. Create a (private) S3 bucket to contain lambda artifacts
    1. update variables.tf (lambda_bucket) w/bucket name
1. upload the lambda function to S3
    1. s3_upload.sh can help
        1.  Creates ping-v01.zip and uploads to s3
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
        1. Copy "Invoke URL" string to `ping1a.sh`
        1. Invoke `ping1a.sh` to exercise POST
    1. Invoke /ping/{id} to exercise get.
