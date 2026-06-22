#! /bin/bash


environment=$1
action=$2
rm -rf .terraform ;
terraform init -backend-config=env/${environment}/state.tfvars ;
terraform plan --var-file=env/${environment}/${environment}.tfvars ;
terraform $action -auto-approve --var-file=env/${environment}/${environment}.tfvars 