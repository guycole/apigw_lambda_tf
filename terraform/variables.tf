#
# variables
#
variable "aws_credentials" {
  description = "fully qualified path to credentials file"
  default = "/Users/gsc/.aws/credentials"
}

variable "aws_profile" {
  description = "profile within credentials file"
  default = "gsc_braingang"
}

variable "aws_region" {
  description = "aws region"
  default = "us-west-2"
}

variable "lambda_bucket" {
  description = "s3 bucket to contain lambda artifacts"
  default = "lambda.braingang.net"
}

variable "lambda_zip" {
  description = "zip file of lambda artifacts"
  default = "ping-v01.zip"
}