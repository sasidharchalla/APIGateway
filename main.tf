module "getlambdas" {
  source = "./modules/getlambdas"
  lambda_name_query_text = var.lambda_name_query_text
  region = var.region
}

module "apigateway" {
  source                    = "./modules/apigateway"
  api_name                  = var.api_name
}

locals {
  list_lambda_names = toset(yamldecode(module.getlambdas.lambda_names))
}

module "apiintegration" {
  for_each = local.list_lambda_names
  source = "./modules/api_integration"
  function_name = each.key
  api_gateway = module.apigateway.api

}

module "apideployment" {
  source = "./modules/deployment"
  stage_name = var.stage_name
  api_gateway = module.apigateway.api
  depends_on = [module.apigateway, module.apiintegration]
}

