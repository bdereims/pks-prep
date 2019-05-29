#!/bin/bash -e

RELEASE=1.1.5

wget https://github.com/istio/istio/releases/download/${RELEASE}/istio-${RELEASE}-linux.tar.gz
tar xvzf istio-${RELEASE}-linux.tar.gz
cd istio-${RELEASE}

helm template install/kubernetes/helm/istio --name istio --namespace istio-system --set kiali.enable=true > $HOME/istio.yaml
