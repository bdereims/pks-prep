#!/bin/bash

. ./env

function rollout () {
	kubectl -n ${NAMESPACE} set image deployment ${1}-deployment ${1}=${FQDN}/${LIBRARY}/${1}
	kubectl -n ${NAMESPACE} rollout status deployment ${1}-deployment
}

rollout nginx
rollout php-fpm
