#
# ping
#
resource "aws_api_gateway_resource" "ping_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  parent_id = "${aws_api_gateway_rest_api.gw_api.root_resource_id}"
  path_part = "ping"
}

resource "aws_api_gateway_method" "ping_get" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  resource_id = "${aws_api_gateway_resource.ping_resource.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ping_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  resource_id = "${aws_api_gateway_method.ping_get.resource_id}"
  http_method = "${aws_api_gateway_method.ping_get.http_method}"
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${aws_lambda_function.ping_lambda.invoke_arn}"
}

resource "aws_api_gateway_deployment" "gw_deploy" {
  depends_on = [
    "aws_api_gateway_integration.ping_integration"
  ]

  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  stage_name = "v01"
}

resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = "${aws_lambda_function.ping_lambda.function_name}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_deployment.gw_deploy.execution_arn}/*/*"
}
