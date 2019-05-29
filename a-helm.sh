#!/bin/bash

. ./env

#kubectl create -f helm-rbac.yaml
curl -L https://git.io/get_helm.sh | bash
helm init --service-account tiller
