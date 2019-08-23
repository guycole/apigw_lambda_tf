#
# variables
#
variable "aws_credentials" {
  description = "fully qualified path to credentials file"
  default     = "/Users/gsc/.aws/credentials"
}

variable "aws_profile" {
  description = "profile within credentials file"
  default     = "gsc_braingang"
}

variable "aws_region" {
  description = "aws region"
  default     = "us-west-2"
}
