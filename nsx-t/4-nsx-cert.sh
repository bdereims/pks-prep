#!/bin/bash

. ../env

cat nsx-cert.cnf | sed -e "s/###NSX_MGR###/${NSX_MANAGER_IP}/" > /tmp/nsx-cert.cnf

#openssl req -newkey rsa:2048 -x509 -nodes \
-keyout nsx.key -new -out nsx.crt -subj /CN=${NSX_MANAGER_IP} \
-reqexts SAN -extensions SAN -config <(cat /tmp/nsx-cert.cnf \
 <(printf "[SAN]\nsubjectAltName=IP:${NSX_MANAGER_IP}")) -sha256 -days 3650

# curl --insecure -u admin:'VMware1!' -X GET https://172.18.13.4/api/v1/trust-management/certificates | jq '.results[] | select(.display_name=="NSX-T Certificat") | .id'
# curl --insecure -u admin:'VMware1!' -X POST 'https://172.18.13.4/api/v1/node/services/http?action=apply_certificate&certificate_id=63123c9d-8d61-4807-b803-4667adc10425'
#exit 0 

openssl req \
-newkey rsa:2048 \
-x509 \
-nodes \
-keyout "$NSX_SUPERUSER_KEY_FILE" \
-new \
-out "$NSX_SUPERUSER_CERT_FILE" \
-subj /CN=pks-nsx-t-superuser \
-extensions client_server_ssl \
-config <(
cat /etc/ssl/openssl.cnf \
<(printf '[client_server_ssl]\nextendedKeyUsage = clientAuth\n')
) \
-sha256 \
-days 3650

cert_request=$(cat <<END
  {
    "display_name": "$PI_NAME",
    "pem_encoded": "$(awk '{printf "%s\\n", $0}' $NSX_SUPERUSER_CERT_FILE)"
  }
END
)

curl -k -X POST \
"https://${NSX_MANAGER_IP}/api/v1/trust-management/certificates?action=import" \
-u "${ADMIN}:${PASSWORD}" \
-H 'content-type: application/json' \
-d "$cert_request"

echo "Look At CERTIFICAT_ID..."
