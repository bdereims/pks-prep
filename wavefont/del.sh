#!/bin/bash

. ./env

HEAPSTER=heapster.yaml
PROXY=proxy.yaml
SERVICE_PROXY=proxy-service.yaml

cat ${PROXY}-src | sed -e "s/###TOKEN###/${TOKEN}/" | kubectl delete -f - 
kubectl delete -f ${SERVICE_PROXY}
cat ${HEAPSTER}-src | sed -e "s/###CLUSTER_NAME###/${CLUSTER_NAME}/" | kubectl delete -f - 
