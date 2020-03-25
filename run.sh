#!/bin/bash
set -e

echo "Starting build process..."

echo "Adding env variables..."
export PATH=/root/bin:$PATH

#Path to k8s config file
KUBECONFIG=/home/blockchain-automation-framework/build/config


echo "Running the playbooks..."
ansible-playbook \
    -vv /home/blockchain-automation-framework/platforms/shared/configuration/site.yaml \
    --inventory-file=/home/blockchain-automation-framework/platforms/shared/inventory/ \
    -e "@/home/blockchain-automation-framework/build/network.yaml" \
    -e 'ansible_python_interpreter=/usr/bin/python3'

ansible-playbook \ 
    -vv examples/supplychain-app/configuration/deploy-supplychain-app.yaml \ 
    --inventory-file=/home/blockchain-automation-framework/platforms/shared/inventory/ \
    -e "@/home/blockchain-automation-framework/build/network.yaml" \
    -e 'ansible_python_interpreter=/usr/bin/python3'