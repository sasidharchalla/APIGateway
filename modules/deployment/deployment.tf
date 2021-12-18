resource "aws_api_gateway_deployment" "deploy_name" {
  rest_api_id = var.api_gateway.id

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_api_gateway_stage" "stage_name" {
  deployment_id = aws_api_gateway_deployment.deploy_name.id
  rest_api_id   = var.api_gateway.id
  stage_name    = var.stage_name
}