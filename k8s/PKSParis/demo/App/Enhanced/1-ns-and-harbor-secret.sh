#!/bin/bash

kubectl create namespace ${LOGNAME}-tito

# Create secret for pivate registry
kubectl -n ${LOGNAME}-tito create secret docker-registry regsecret --docker-server=https://harbor.pks-reg.gv --docker-username="demo" --docker-password="PKSParis1!" --docker-email="admin@pks.demo"
