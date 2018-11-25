#!/bin/bash
#bdereims@vmware.com

. ../env

NETWORK_MANAGER_USERNAME=${ADMIN}
NETWORK_MANAGER_PASSWORD=$NSX_COMMON_PASSWORD

NODE_ID=$(cat /proc/sys/kernel/random/uuid)

# This function returns id from rest response
function get_response_id() {
  echo ${1} | jq '.results[] | .id ' | tr -d '""' 
}

# This function imports certificat in NSX Manager
function import_certificat() {
  echo "import_certificat"
  CERT=$(awk '{printf "%s\\n", $0}' nsx.crt)
  KEY=$(awk '{printf "%s\\n", $0}' nsx.key)
  local certificat_json="{ \
    \"pem_encoded\":\"${CERT}\", \
    \"private_key\":\"${KEY}\" \
  }"
  get_rest_response "api/v1/trust-management/certificates?action=import" "$certificat_json"
}

# This function returns REST response. Currently based on payload it decides whether to use
# GET or POST
function get_rest_response() {
  local api=${1}
  local payload=${2}

  if [[ ! -n "$payload" ]]; then
    curl -sS -k -u $NETWORK_MANAGER_USERNAME:$NETWORK_MANAGER_PASSWORD https://$NSX_MANAGER_IP/$api
  else
    curl -sS -H "Content-Type: application/json" -k -u $NETWORK_MANAGER_USERNAME:$NETWORK_MANAGER_PASSWORD -X POST -d "$payload" https://$NSX_MANAGER_IP/$api
  fi

}

###################################################
# Create certificat and key for NSX service account
###################################################

openssl req \
-newkey rsa:2048 \
-x509 \
-nodes \
-keyout "${NSX_SUPERUSER_KEY_FILE}" \
-new \
-out "${NSX_SUPERUSER_CERT_FILE}" \
-subj /CN="${PI_NAME}" \
-extensions client_server_ssl \
-config <( cat /etc/ssl/openssl.cnf \
<(printf '[client_server_ssl]\nextendedKeyUsage = clientAuth\n')) \
-sha256 \
-days 3650

cert_request=$( cat <<END
  {
    "display_name": "$PI_NAME",
    "pem_encoded": "$(awk '{printf "%s\\n", $0}' $NSX_SUPERUSER_CERT_FILE)"
  }
END
)

response=$( get_rest_response "api/v1/trust-management/certificates?action=import" "${cert_request}" )
CERTIFICAT_ID=$( get_response_id "${response}" )

pi_request=$(cat <<END
  {
    "display_name": "$PI_NAME",
    "name": "$PI_NAME",
    "permission_group": "superusers",
    "certificate_id": "$CERTIFICAT_ID",
    "node_id": "$NODE_ID"
  }
END
)

get_rest_response "api/v1/trust-management/principal-identities" "${pi_request}"

echo " "
echo "Wait a bit before it's enabled..."
sleep 20

# Test if it works with service account cert
printf "\n\nTest:\n"
curl -k -X GET \
"https://${NSX_MANAGER_IP}/api/v1/trust-management/principal-identities" \
--cert "$NSX_SUPERUSER_CERT_FILE" \
--key "$NSX_SUPERUSER_KEY_FILE"

####################################################
#Create a new sefl-signed certificat for NSX Manager 
####################################################

cat nsx-cert.cnf | sed -e "s/###NSX_CN###/${NSX_COMMON_DOMAIN}/" > /tmp/nsx-cert.cnf

# Create NSX Web certificat
echo "create NSX Web certificate"
openssl req -newkey rsa:2048 -x509 -nodes \
-keyout nsx.key -new -out nsx.crt -subj /CN=${NSX_COMMON_DOMAIN} \
-reqexts SAN -extensions SAN -config <(cat /tmp/nsx-cert.cnf \
<(printf "[SAN]\nsubjectAltName=DNS:${NSX_COMMON_DOMAIN},IP:${NSX_MANAGER_IP}")) -sha256 -days 3650

# Apply and activate certificat in NSX
response=$( import_certificat | sed -e "s/^import_certificat//" )
#response=$( echo ${response} | sed -e "s/^import_certificat//" )
certificat_id=$(get_response_id "$response")
curl --insecure -u ${ADMIN}:${PASSWORD} -X POST "https://$NSX_MANAGER_IP/api/v1/node/services/http?action=apply_certificate&certificate_id=${certificat_id}"
