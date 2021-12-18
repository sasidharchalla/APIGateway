Commands to run

1)git clone https://github.com/sasidharchalla/APIGateway.git
2)cd APIGateway/modules/getlambdas
3)terraform init
3)terraform plan -var-file=../../environments/test.tfvars
4)terraform apply --auto-approve -var-file=../../environments/test.tfvars
5)cd ../../
6)terraform init
7)terraform plan -var-file=./environments/test.tfvars -out APIgatewayplan
8)terraform apply "APIgatewayplan"
