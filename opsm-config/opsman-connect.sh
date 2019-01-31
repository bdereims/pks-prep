#!/bin/bash
#bdereims@vmware.com

. ../env

rm ~/.uaac.yml
uaac --skip-ssl-validation target https://${OPSMANAGER}/uaa
uaac token owner get -s "" -p "${PASSWORD}" opsman "${ADMIN}"
TOKEN=$( uaac context | grep access_token | sed -e "s/^.*: //" )

export TOKEN
