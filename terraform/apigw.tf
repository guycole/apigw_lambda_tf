#
# api gw
#
resource "aws_api_gateway_rest_api" "gw_api" {
  name = "PingGateway"
  description = "Ping Gateway"
#  body = data.template_file.swagger.rendered

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

#resource "aws_api_gateway_domain_name" "gw_domain" {
#  domain_name = "braingang.net"
#}

#resource "aws_api_gateway_base_path_mapping" "gw_map" {
#  rest_api_id = "${aws_api_gateway_rest_api.gw_api.id}"
#}


data "template_file" "swagger" {
  vars = {
    post_lambda_arn = aws_lambda_function.ping_lambda.invoke_arn
  }

  template = file("swagger.yaml")
}