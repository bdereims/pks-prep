#!/bin/bash
#bdereims@vmware.com

. ../../env

NSX_MANAGER=${NSX_COMMON_DOMAIN}
NSX_USER=${ADMIN}
NSX_USER_PASSWD=${PASSWORD}

nsx_call() {
	# $1 : [GET, POST, DELETE] 
	# $2 : REST Call 

	curl -sS -k -X ${1} -u ${NSX_USER}:${NSX_USER_PASSWD} https://${NSX_MANAGER}${2}
}

nsx_call_payload() {
        # $1 : [GET, POST, DELETE]
        # $2 : REST Call
        # $3 : JSON Payload 

        #curl -sS -k -H "content-type: application/json" -d @${3} -X ${1} -u ${NSX_USER}:${NSX_USER_PASSWD} https://${NSX_MANAGER}${2}
	curl -k -X ${1} "-H "content-type: application/json" -d @${3} "https://${NSX_MANAGER}${2}" --cert "$NSX_SUPERUSER_CERT_FILE" --key "$NSX_SUPERUSER_KEY_FLE"
}

create_nsx_session() {
	curl -k -c cookies.$$ -D headers.$$ -X POST \
	-d "j_username=${NSX_USER}&j_password=${NSX_USER_PASSWD}" \
	https://${NSX_MANAGER}/api/session/create
}

delete_nsx_session() {
	nsx_call GET "/api/session/destroy"
	rm cookies.$$ headers.$$
}

clean_ip_pool() {
	echo "Delete IP Pool"

	nsx_call GET "/api/v1/pools/ip-pools/${1}/allocations" > aip.lst
	for AIP in $( cat aip.lst | jq '.["results"] | .[] | .allocation_id' )
	do
		echo "Clean: ${AIP}"
		echo "{ \"allocation_id\": ${AIP} }" > aip.$$
		nsx_call_payload POST "/api/v1/pools/ip-pools/${1}?action=RELEASE" "aip.$$"
	done

	#nsx_call DELETE "/api/v1/pools/ip-pools/${1}?force=true"

	rm aip.$$
	rm aip.lst
}

main() {
	echo "Cleaning Up NSX-T"

	clean_ip_pool "5ba0103a-a766-4abe-8deb-56c0d7c3e2ba"

}

main
