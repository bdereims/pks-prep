#!/bin/bash
#bdereims@gmail.com

. ./env

kubectl create namespace ${NAMESPACE} 
./kubectl_create.sh back-end.yaml
./kubectl_create.sh front-end.yaml

watch kubectl get pods,svc,ingress -n ${NAMESPACE} 
