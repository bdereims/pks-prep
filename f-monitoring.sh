#!/bin/bash -e
#bdereims@vmware.com

kubectl apply --filename https://raw.githubusercontent.com/giantswarm/kubernetes-prometheus/master/manifests-all.yaml

kubectl -n monitoring get svc grafana -o yaml | sed -e "s/NodePort/LoadBalancer/" -e "s/port: 3000/port: 80/"| kubectl -n monitoring apply -f -
kubectl -n monitoring get svc grafana -o jsonpath={.status.loadBalancer.ingress[0].ip}
