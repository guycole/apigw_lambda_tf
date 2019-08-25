#
# api gw
#
resource "aws_api_gateway_rest_api" "gw_api" {
  name = "PingGateway"
  description = "Ping Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
