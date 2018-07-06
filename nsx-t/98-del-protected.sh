#!/bin/bash
#bdereims@vmware.com

. ../env


main() {
	curl -sS -k -X DELETE -H X-Allow-Overwrite=true --cert $(pwd)/"$NSX_SUPERUSER_CERT_FILE" --key $(pwd)/"$NSX_SUPERUSER_KEY_FILE" 'https://nsx.cpod-lab.shwrfr.mooo.com/api/v1/logical-router-ports/d241a67f-d55e-4243-8532-ea39d19a8bdf?force=true'
}

main
