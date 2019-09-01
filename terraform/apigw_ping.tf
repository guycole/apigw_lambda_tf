#
# ping
#
resource "aws_api_gateway_resource" "ping_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  parent_id = "${aws_api_gateway_rest_api.gw_api.root_resource_id}"
  path_part = "resource"
}

#######################
# Method Request
#######################

resource "aws_api_gateway_request_validator" "ping_validator" {
  name = "ping validator"
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  validate_request_body = true
  validate_request_parameters = true
}

resource "aws_api_gateway_method" "ping_get" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  resource_id = "${aws_api_gateway_resource.ping_resource.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ping_post" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  resource_id = "${aws_api_gateway_resource.ping_resource.id}"
  http_method = "POST"
  authorization = "NONE"

  request_models = {"application/json" = "PingRequestV1"}
  request_validator_id = "${aws_api_gateway_request_validator.ping_validator.id}"
  depends_on = ["aws_api_gateway_model.ping_request_model"]
}

#######################
# Integration Request
#######################

resource "aws_api_gateway_integration" "ping_get_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  resource_id = "${aws_api_gateway_method.ping_get.resource_id}"
  http_method = "${aws_api_gateway_method.ping_get.http_method}"
  type = "AWS_PROXY"
  integration_http_method = "POST"
  uri = "${aws_lambda_function.ping_lambda.invoke_arn}"

  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
  }
}

resource "aws_api_gateway_integration" "ping_post_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  resource_id = "${aws_api_gateway_method.ping_post.resource_id}"
  http_method = "${aws_api_gateway_method.ping_post.http_method}"
  type = "MOCK"
  #    type = "AWS_PROXY"

  integration_http_method = "POST"
  uri = "${aws_lambda_function.ping_lambda.invoke_arn}"

  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
  }
}

#######################
# Method Response
#######################

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  resource_id = "${aws_api_gateway_resource.ping_resource.id}"
  http_method = "${aws_api_gateway_method.ping_get.http_method}"
  status_code = "200"

  response_models = {"application/json" = "PingResponseV1"}
}

resource "aws_api_gateway_method_response" "response_400" {
  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  resource_id = "${aws_api_gateway_resource.ping_resource.id}"
  http_method = "${aws_api_gateway_method.ping_get.http_method}"
  status_code = "400"

  response_models = {"application/json" = "PingResponseV1"}
}

#######################
# Integration Response
#######################

#resource "aws_api_gateway_integration_response" "ping_integration_response" {
#  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
#  resource_id = "${aws_api_gateway_resource.ping_resource.id}"
#  http_method = "${aws_api_gateway_method.ping_get.http_method}"
#  status_code = "${aws_api_gateway_method_response.response_200.status_code}"
##  selection_pattern = "-"
#  selection_pattern = ".*message.*"
#
#  response_templates = {
#    "application/json" = <<EOF
##set($inputRoot = $input.path('$'))
#{
#  "preamble" : {
#    "transactionUuid" : "foo",
#    "messageVersion" : 42,
#    "messageType" : "foo"
#  },
#  "pingState" : true
#}
#EOF
#  }
#}

#######

resource "aws_api_gateway_deployment" "gw_deploy" {
  depends_on = [
    "aws_api_gateway_integration.ping_get_integration",
    "aws_api_gateway_integration.ping_post_integration"
  ]

  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
  stage_name = "stagetest"
}

resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = "${aws_lambda_function.ping_lambda.function_name}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_deployment.gw_deploy.execution_arn}/*/*"
}
