#!/bin/bash
# Purpose - Create, deploy or destroy AWS resources using Terraform.

COMMAND=$1
BASTION_IP=$3
PRIVATE_IP=$5

usage() { echo "$0 usage:" && grep " .)\ #" "$0"; exit 0; }

helper() {
cat << EOF
Usage: devops.sh <command> -i <instance-ip> [-ih]
Install Pre-requisites for EspoCRM with docker in Development mode

<command>           Set script command [create|destroy|deploy]
-h                  Display help
-b                  Bastion instance public IP
-p                  Application instance private IP
EOF
}

while getopts "c:b:ph" flag; do
  case "${flag}" in
    c) COMMAND=$OPTARG;;
    b) BASTION_IP=$OPTARG;;
    p) PRIVATE_IP=$OPTARG;;
    h) helper;;
    *) usage
  esac
done

if [[ -z $COMMAND ]]; then
  echo "Please use command -c flag to set [create|destroy|deploy]."
fi

if [[ $COMMAND = "deploy" && -z "$BASTION_IP" && -z "$PRIVATE_IP" ]]; then
  echo "Please use command -b and -p flags to set instance IPs."
fi

if [[ $COMMAND = "create" ]]; then
  ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "ec2-user@instance" \
    -f "$HOME/.ssh/fork" \
    -N 1q2w3e4r
  echo "Creating..."
  terraform init
  terraform apply -auto-approve
  echo "Created."

elif [[ $COMMAND = "destroy" ]]; then
  echo "Destorying..."
  terraform destroy -auto-approve
  echo "Destroyed."

elif [[ $COMMAND = "deploy" ]]; then
  echo "Deploying..."
  echo "$BASTION_IP"
  echo "$PRIVATE_IP"

  ssh-keyscan -H "BASTION_IP" >> ~/.ssh/known_hosts
  exit | ssh -i ~/.ssh/fork ec2-user@"$BASTION_IP"
  ssh -i ~/.ssh/fork ec2-user@"$PRIVATE_IP"

  # Stop app server
  pm2 stop app

  # Git clone the lastest version
  rm -r node-hello-world || exit
  git clone https://github.com/IBM/node-hello-world
  cd node-hello-world || exit
  npm install
  pm2 start app.js
fi