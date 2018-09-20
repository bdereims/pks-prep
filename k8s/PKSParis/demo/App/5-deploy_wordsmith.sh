#!/bin/bash

kubectl create namespace ${LOGNAME}-wordsmith
kubectl -n ${LOGNAME}-wordsmith apply -f ./k8s-wordsmith-demo/kube-deployment.yml 

watch -c -d -n1 kubectl get services -n ${LOGNAME}
