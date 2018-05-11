#!/bin/bash

. ./env

kubectl create -f helm-rbac.yaml
helm init --service-account tiller
