#!/bin/bash -e
#bdereims@vmware.com

helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.1.5/charts/
helm install istio.io/istio-init --name istio-init --namespace istio-system --set kiali.enable=true
#kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l
helm install istio.io/kubernetes/helm/istio --name istio --namespace istio-system --set kiali.enable=true
