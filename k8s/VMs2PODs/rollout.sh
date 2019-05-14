#!/bin/bash

REGISTRY="harbor.cpod-fresh-bream.az-demo.shwrfr.com/library"

function rollout () {
	kubectl set image deployment ${1}-deployment nginx=${REGISTRY}/${1}:latest
	kubectl rollout status deployment ${1}-deployment
}

rollout nginx
rollout php-fpm
