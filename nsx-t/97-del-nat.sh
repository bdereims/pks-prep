#!/bin/bash

.. ./env

curl -sS -k -X GET --cert "$NSX_SUPERUSER_CERT_FILE" --key "$NSX_SUPERUSER_KEY_FILE" https://172.18.13.4/api/v1/logical-routers/f96b5a1a-0c4d-40c3-8bb7-833ad824a278/nat/rules
curl -sS -k -X DELETE --cert "$NSX_SUPERUSER_CERT_FILE" --key "$NSX_SUPERUSER_KEY_FILE" https://172.18.13.4/api/v1/logical-routers/f96b5a1a-0c4d-40c3-8bb7-833ad824a278/nat/rules/1027
