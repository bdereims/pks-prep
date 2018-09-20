#!/bin/bash

kubectl -n ${LOGNAME}-tito apply -f tito-fe-rc.yml
kubectl -n ${LOGNAME}-tito apply -f tito-fe-service.yml

kubectl -n ${LOGNAME}-tito apply -f tito-sql-pod.yml 
kubectl -n ${LOGNAME}-tito apply -f tito-sql-service.yml 
