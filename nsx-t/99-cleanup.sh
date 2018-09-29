#!/bin/bash
#bdereims@vmware.com

NSX_MANAGER=nsx.cpod-vbc-sddc.rax.lab
NSX_USER=admin
NSX_USER_PASSWD=fbj0qS3AQtxa6BC!

nsx_call() {
	# $1 : [GET, POST, DELETE] 
	# $2 : REST Call 

	curl -sS -k -X ${1} -u ${NSX_USER}:${NSX_USER_PASSWD} https://${NSX_MANAGER}${2}
}

nsx_call_payload() {
        # $1 : [GET, POST, DELETE]
        # $2 : REST Call
        # $3 : JSON Payload 

        curl -sS -k -H "content-type: application/json" -d @${3} -X ${1} -u ${NSX_USER}:${NSX_USER_PASSWD} https://${NSX_MANAGER}${2}
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
		echo "{ \"allocation_id\": ${AIP} }"
		echo "{ \"allocation_id\": ${AIP} }" > aip.$$
		#curl -k -b cookies.$$ -H "`grep X-XSRF-TOKEN headers.$$`" \
		#-X POST -d @aip.$$ \
		#-H 'Content-Type: application/json;charset=UTF-8' \
		#-i https://${NSX_MANAGER}/api/v1/pools/ip-pools/${1}?action=RELEASE
		nsx_call_payload POST "/api/v1/pools/ip-pools/${1}?action=RELEASE" aip.$$
	done

	#curl -k -b cookies.$$ -H "`grep X-XSRF-TOKEN headers.$$`" \
	#-X DELETE \
	#-H 'Content-Type: application/json;charset=UTF-8' \
	#-i https://${NSX_MANAGER}/api/v1/pools/ip-pools/${1}

	#nsx_call DELETE "/api/v1/pools/ip-pools/${1}?force=true"

	rm aip.$$
	rm aip.lst
}

main() {
	echo "Cleaning Up NSX-T"

	clean_ip_pool "3c8788d6-314c-4011-87fc-c57269721685"
}

main
