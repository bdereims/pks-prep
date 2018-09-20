#!/bin/bash

kubectl create namespace ${LOGNAME}
kubectl -n ${LOGNAME} run my-app --image=docker.io/ecointet/pivotal-webserver --port=80
