#!/bin/bash -e

curl -L https://git.io/getLatestIstio | sh -
cd istio-*

kubectl create -f install/kubernetes/helm/helm-service-account.yaml
helm init --wait --service-account tiller

#helm install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system --set kiali.enable=true
#helm install --wait --name istio-init --namespace istio-system install/kubernetes/helm/istio-init
#helm install install/kubernetes/helm/istio --name istio --namespace istio-system --set kiali.enable=true
#helm install --wait --name istio --namespace istio-system install/kubernetes/helm/istio --values install/kubernetes/helm/istio/values-istio-demo.yaml 

helm template --name istio-init --namespace istio-system install/kubernetes/helm/istio-init | kubectl create -f -
helm template --name istio --namespace istio-system install/kubernetes/helm/istio --values install/kubernetes/helm/istio/values-istio-demo.yaml | kubectl create -f -

kubectl label namespace default istio-injection=enabled

exit 0

kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

export INGRESS_HOST=$(kubectl -n istio-system \
get service istio-ingressgateway \
-o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system \
get service istio-ingressgateway \
-o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

echo "http://$GATEWAY_URL/productpage"
