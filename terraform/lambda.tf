#
# lambda
#
resource "aws_iam_role" "ping_role" {
  name = "traveler-ping-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_lambda_function" "ping_lambda" {
  s3_bucket     = "lambda.braingang.net"
  s3_key        = "ping-v01.zip"
  function_name = "ping_handler"
  handler       = "ping_v01.handler"
  role          = "${aws_iam_role.ping_role.arn}"
  description   = "ping message handler"
  runtime       = "python3.7"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
