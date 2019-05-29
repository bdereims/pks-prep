#!/bin/bash

. ./env

curl -LO https://git.io/get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh

kubectl create -f helm-rbac.yaml
helm init --service-account tiller

