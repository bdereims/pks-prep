#!/bin/bash
#bdereims@vmware.com

bosh -e pks tasks --json | jq .Tables[].Rows[].id -Mr | xargs -n 1 bosh -e pks cancel-task
