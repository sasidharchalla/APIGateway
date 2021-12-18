resource "null_resource" "get_lambda_func_name" {
  triggers = {
    build_number = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "aws lambda list-functions --no-verify-ssl --region ${var.region} --query 'Functions[?starts_with(FunctionName, `${var.lambda_name_query_text}`) == `true`].FunctionName' --output yaml > ${data.template_file.lambda_template.rendered}"
  }

}


data "template_file" "lambda_template" {
  template = "${path.module}/lambda_names.yaml"
}

data "local_file" "lambda_names_file" {
  filename   = data.template_file.lambda_template.rendered
  depends_on = [null_resource.get_lambda_func_name]
}
