#!/bin/bash
#bdereims@vmware.com

. ../env

. ./opsman-connect.sh

curl -s -k -H 'Accept: application/json;charset=utf-8' \
	-H "Content-Type: multipart/form-data" -H "Authorization: Bearer ${TOKEN}" \
	https://${OPSMANAGER}/api/v0/staged/installations/commit \
	-X POST 
