#!/bin/bash

kubectl create -f helm-rbac.yaml
curl -L https://git.io/get_helm.sh | bash
helm init --wait --service-account tiller
