#!/bin/bash

cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Service
metadata:
  annotations:
  labels:
    k8s-app: kube-dns 
  name: kube-dns-lb 
  namespace: kube-system
spec:
  ports:
  - name: dns 
    protocol: UDP 
    targetPort: 53 
    port: 53 
  selector:
    k8s-app: kube-dns
  sessionAffinity: None
  type: LoadBalancer
EOF
