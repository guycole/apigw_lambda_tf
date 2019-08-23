#
# api gw
#
resource "aws_api_gateway_rest_api" "gw_api" {
  name = "JadedTravelerGateway"
  description = "Jaded Traveler API Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
