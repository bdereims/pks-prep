#!/bin/bash
#bdereims@vmware.com

. ../../env

# ${1} : full api request to NSX manager
request() {
	curl -sS -k -X DELETE -H X-Allow-Overwrite=true --cert $(pwd)/"$NSX_SUPERUSER_CERT_FILE" --key $(pwd)/"$NSX_SUPERUSER_KEY_FILE" "https://nsx-1.${DOMAIN}${1}"
}

# Delete Router Port
del_router_port() {
	request "/api/v1/logical-router-ports/${1}?force=true"
}

del_ip_set() {
	request "/api/v1/ip-sets/${1}"
}

# Router
#request "/api/v1/logical-routers/4711a2de-501c-4a88-ada7-ef59b3cb5c2d?force=true"

#del_router_port 67a806b3-eaf8-4af7-b13c-f215228921b5 
del_ip_set c6114941-d691-439c-b3aa-8ace419be008

