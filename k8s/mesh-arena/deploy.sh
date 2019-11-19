#!/bin/bash -e

NAMESPACE=arena

kubectl create namespace ${NAMESPACE} 
kubectl config set-context --current --namespace=${NAMESPACE}

cd demo-mesh-arena

kubectl apply -f <(istioctl kube-inject -f ./services/ui/Deployment.yml)
kubectl create -f ./services/ui/Service.yml
kubectl apply -f mesh-arena-gateway.yaml

echo "Playground should be reade!"
read

## Deploy stadium & ball
kubectl apply -f <(istioctl kube-inject -f ./services/stadium/Deployment-Smaller.yml)
kubectl create -f ./services/stadium/Service.yml
kubectl apply -f <(istioctl kube-inject -f ./services/ball/Deployment.yml)
kubectl create -f ./services/ball/Service.yml

#read

## Deploy 2x2 players
kubectl apply -f <(istioctl kube-inject -f ./services/ai/Deployment-2-locals.yml)
#kubectl create -f ./services/ai/Service-locals.yml
kubectl apply -f <(istioctl kube-inject -f ./services/ai/Deployment-2-visitors.yml)
#kubectl create -f ./services/ai/Service-visitors.yml
kubectl create -f ./services/ai/Service.yml

kubectl config set-context --current --namespace=default
