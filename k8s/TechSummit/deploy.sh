#!/bin/bash

kubectl create namespace avalanche
kubectl create -f back-end.yaml
kubectl create -f front-end.yaml
