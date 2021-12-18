
### Commands to run
```
git clone https://github.com/sasidharchalla/APIGateway.git
```
The below commands are used to generate lambda function names to modules/getlambdas/lambda_names.yaml, 
This is just a workaround.

In Pipeline you can run an aws cli command to generate lambda function names to a file and will be used in subsequent terraform runs.
```
cd APIGateway/modules/getlambdas
terraform init
terraform plan -var-file=../../environments/test.tfvars
terraform apply --auto-approve -var-file=../../environments/test.tfvars
```
Now main terraform code comes into picture, i.e main.tf in root directory
```
cd ../../
terraform init
terraform plan -var-file=./environments/test.tfvars -out APIgatewayplan
terraform apply "APIgatewayplan"
```
To destroy the infrastructure
```
terraform plan -destroy -var-file=./environments/test.tfvars -out APIGatewayDestroy
terraform apply "APIGatewayDestroy"
```
