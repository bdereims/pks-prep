#!/bin/bash

kubectl -n ${LOGNAME} expose deployment my-app --type=LoadBalancer --port=80 --target-port=80

watch -c -d -n1 kubectl get service --all-namespaces
