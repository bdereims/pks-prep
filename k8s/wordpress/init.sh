#!/bin/bash

kubectl create ns wordpress-example

kubectl create -f mariadb-deployment.yaml
kubectl create -f mariadb-service.yaml
kubectl create -f wordpress-deployment.yaml
kubectl create -f wordpress-service.yaml
