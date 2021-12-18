output "lambda_names" {
    value = data.local_file.lambda_names_file.content
}