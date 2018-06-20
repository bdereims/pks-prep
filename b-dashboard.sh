#!/bin/bash

kubectl -n kube-system delete svc/kubernetes-dashboard

cat <<EOF | kubectl create -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: kubernetes-dashboard
  labels:
    k8s-app: kubernetes-dashboard
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: kubernetes-dashboard
  namespace: kube-system
EOF

cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Service
metadata:
  annotations:
  labels:
    k8s-app: kubernetes-dashboard
  name: kubernetes-dashboard
  namespace: kube-system
spec:
  ports:
  - name: https
    targetPort: 8443
    port: 8443
  selector:
    k8s-app: kubernetes-dashboard
  sessionAffinity: None
  type: LoadBalancer
EOF
