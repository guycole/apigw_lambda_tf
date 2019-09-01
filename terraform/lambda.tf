#
# lambda
#
resource "aws_iam_role" "ping_assumable_role" {
  name = "ping-role"
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
  s3_bucket = var.lambda_bucket
  s3_key = var.lambda_zip
  function_name = "ping_handler"
  handler = "ping_v01.handler"
  role = "${aws_iam_role.ping_assumable_role.arn}"
  description = "ping message handler"
  runtime = "python3.7"
}

resource "aws_iam_policy" "ping_lambda_logging" {
  name = "ping_lambda_logging"
  path = "/"
  description = "ping lambda logging"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role = "${aws_iam_role.ping_assumable_role.name}"
  policy_arn = "${aws_iam_policy.ping_lambda_logging.arn}"
}
