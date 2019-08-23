#
# lambda
#
resource "aws_iam_role" "ping_role" {
  name = "traveler-ping-role"
  assume_role_policy = file("ping_policy.json")

  tags = {
    Name = "traveler-ping-role"
    Project = "traveler"
  }
}

resource "aws_lambda_function" "ping_lambda" {
  s3_bucket     = "dev.robobuzzer.com"
  s3_key        = "lambda-ore/ping-v01.zip"
  function_name = "pingx"
  handler       = "ping_v01.handler"
  role          = aws_iam_role.ping_role.arn
  description   = "ping message handler"
  runtime       = "python3.7"

  environment {
    variables = {
      foo = "bar"
    }
  }
}