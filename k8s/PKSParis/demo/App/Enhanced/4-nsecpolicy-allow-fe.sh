#!/bin/bash

kubectl -n ${LOGNAME}-tito apply -f tito-fe-nsecpolicy-allow-fe.yml 
