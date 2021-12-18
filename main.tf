resource "null_resource" "get_lambda_func_name" {
    triggers = {
        build_number = "${timestamp()}"
    }
    provisioner "local-exec" {
      command = "aws lambda list-functions --no-verify-ssl --region ${var.region} --query 'Functions[?starts_with(FunctionName, `${var.lambda_name_query_text}`) == `true`].FunctionName' --output yaml > ${data.template_file.lambda_template.rendered}"
      //the below line needs to be removed since its a powershell command(for testing on windows), and only works on windows, But CI pipeline runs on Linux machine.
      //interpreter = ["PowerShell", "-Command"]
    }
  
}


data "template_file" "lambda_template" {
    template = "${path.module}/lambda_names.yaml"
}

data "local_file" "lambda_names" {
    filename = "${data.template_file.lambda_template.rendered}"
    depends_on = [null_resource.get_lambda_func_name]
}

locals {
  list_lambda_names = tolist(yamldecode(data.local_file.lambda_names.content))
}

/*module "apigateway" {
  source                    = "./modules/apigateway"
  api_name                  = var.api_name
}*/

output "lambda_names" {
 value = local.list_lambda_names[2]
}

/*module "apiintegration" {
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
}*/

