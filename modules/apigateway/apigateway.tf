
resource "aws_api_gateway_rest_api" "api_gateway" {
    name = var.api_name
    endpoint_configuration {
    types = ["EDGE"]
  }
}