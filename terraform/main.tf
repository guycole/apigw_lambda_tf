#
# main
#
provider "aws" {
  shared_credentials_file = var.aws_credentials
  profile = var.aws_profile
  region = var.aws_region
}
