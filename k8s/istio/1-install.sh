#!/bin/bash -e

curl -L https://git.io/getLatestIstio | sh -
cd istio-*
helm install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system --set kiali.enable=true
helm install install/kubernetes/helm/istio --name istio --namespace istio-system --set kiali.enable=true
