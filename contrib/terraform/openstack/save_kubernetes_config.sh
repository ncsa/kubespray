#!/bin/bash
echo "Setting up kubectl config for new cluster..."
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no centos@MASTER_ADDRESS sudo cat /etc/kubernetes/ssl/admin-CLUSTERNAME-k8s-master-1-key.pem > admin-key.pem
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no centos@MASTER_ADDRESS sudo cat /etc/kubernetes/ssl/admin-CLUSTERNAME-k8s-master-1.pem > admin.pem
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no centos@MASTER_ADDRESS sudo cat /etc/kubernetes/ssl/ca.pem > ca.pem

kubectl config set-cluster default-cluster --server=https://MASTER_ADDRESS:6443 \
    --insecure-skip-tls-verify=true

kubectl config set-credentials default-admin \
    --certificate-authority=ca.pem \
    --client-key=admin-key.pem \
    --client-certificate=admin.pem

kubectl config set-context default-system --cluster=default-cluster --user=default-admin
