#
# ping
#
resource "aws_api_gateway_model" "ping_request_model" {
  rest_api_id  = "${aws_api_gateway_rest_api.gw_api.id}"
  name = "PingRequest"
  description  = "ping request model"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "PingRequest",
  "type": "object",
  "properties": {
    "preamble": {
      "type": "object",
      "properties": {
        "transactionUuid": {
          "description": "client generated transaction UUID",
          "type": "string",
          "format": "uuid"
        },
        "messageVersion": {
          "description": "defined by URL",
          "type": "integer"
        },
        "messageType": {
          "description": "defined by URL",
          "type": "string"
        }
      },
      "required": ["transactionUuid"]
    },
    "pingState": {"type": "boolean"}
  },
  "required": ["preamble", "pingState"]
}
EOF
}

resource "aws_api_gateway_model" "ping_response_model" {
  rest_api_id  = "${aws_api_gateway_rest_api.gw_api.id}"
  name = "PingResponse"
  description  = "ping response model"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "PingResponse",
  "type": "object",
  "properties": {
    "preamble": {
      "type": "object",
      "properties": {
        "transactionUuid": {
          "description": "client generated transaction UUID",
          "type": "string",
          "format": "uuid"
        },
        "messageVersion": {
          "description": "defined by URL",
          "type": "integer"
        },
        "messageType": {
          "description": "defined by URL",
          "type": "string"
        }
      },
      "required": ["transactionUuid"]
    },
    "pingState": {"type": "boolean"}
  },
  "required": ["preamble", "pingState"]
}
EOF
}

