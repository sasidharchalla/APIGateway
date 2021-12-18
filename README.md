Commands to run

1)git clone https://github.com/sasidharchalla/APIGateway.git
2)cd APIGateway/modules/getlambdas
3)terraform init
4)terraform plan -var-file=../../environments/test.tfvars
5)terraform apply --auto-approve -var-file=../../environments/test.tfvars
6)cd ../../
7)terraform init
8)terraform plan -var-file=./environments/test.tfvars -out APIgatewayplan
9)terraform apply "APIgatewayplan"
