#! /bin/bash


environment=$1
action=$2
rm -rf .terraform ;
terraform init -backend-config=env/${environment}/state.tfvars ;
terraform plan --var-file=env/${environment}/${environment}.tfvars ;
terraform $action -auto-approve --var-file=env/${environment}/${environment}.tfvars

if [ $? -ne 0 ]; then
   echo -e "\e[31m Terraform $action failed! \e[0m"
   exit 1
else
   echo -e "\e[32m Terraform $action completed successfully! \e[0m"
fi

echo " aws eks update-kubeconfig \ 
  --region us-east-1 \ 
  --name robodefense-cluster-test " 