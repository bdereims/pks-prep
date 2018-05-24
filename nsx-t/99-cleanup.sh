#!/bin/bash
#bdereims@vmware.com

NSX_MANAGER=nsx.cpod-gv.shwrfr.mooo.com
NSX_USER=admin
NSX_USER_PASSWD=VMware1!

nsx_call() {
	# $1 : [GET, POST, DELETE] 
	# $2 : REST Call 
	# $3 : Payload in JSON

        curl -k -b cookies.$$ -H "`grep X-XSRF-TOKEN headers.$$`" \
	-X ${1} -d @${3} \
	-H 'Content-Type: application/json;charset=UTF-8' \
        -i https://${NSX_MANAGER}${2}
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
	for AIP in $( tail -n +8 aip.lst | jq '.["results"] | .[] | .allocation_id' )
	do
		echo "{ \"allocation_id\": ${AIP} }"
		echo "{ \"allocation_id\": ${AIP} }" > aip.$$
		#curl -k -b cookies.$$ -H "`grep X-XSRF-TOKEN headers.$$`" \
		#-X POST -d @aip.$$ \
		#-H 'Content-Type: application/json;charset=UTF-8' \
		#-i https://${NSX_MANAGER}/api/v1/pools/ip-pools/${1}?action=RELEASE
		nsx_call POST "/api/v1/pools/ip-pools/${1}?action=RELEASE" aip.$$ 
	done

	#curl -k -b cookies.$$ -H "`grep X-XSRF-TOKEN headers.$$`" \
	#-X DELETE \
	#-H 'Content-Type: application/json;charset=UTF-8' \
	#-i https://${NSX_MANAGER}/api/v1/pools/ip-pools/${1}

	nsx_call DELETE "/api/v1/pools/ip-pools/${1}?force=true"

	rm aip.lst
}

main() {
	echo "Cleaning Up NSX-T"
	create_nsx_session

	clean_ip_pool "fa2d3676-e7c2-488a-b177-871209709700"

	delete_nsx_session
}

main
