#
# api gw
#
resource "aws_api_gateway_rest_api" "gw_api" {
  name = "PingGateway"
  description = "Ping Gateway"
  body = data.template_file.swagger.rendered

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "gw_deploy" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  stage_name  = "v01"
}

resource "aws_lambda_permission" "cloudwatch_ping_lambda" {
  statement_id = "bogus"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ping_lambda.function_name}"
  principal = "events.amazonaws.com"
}

resource "aws_lambda_permission" "invoke_ping_lambda" {
  statement_id = "AllowPingGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ping_lambda.function_name}"
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.gw_api.execution_arn}/*/*/*"
}

data "template_file" "swagger" {
  vars = {
    ping_lambda_arn = aws_lambda_function.ping_lambda.invoke_arn
  }

  template = file("swagger.yaml")
}

output "invoke_url" {
  value = "${aws_api_gateway_deployment.gw_deploy.invoke_url}"
}
