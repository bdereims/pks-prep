#!/bin/bash

exit 0

###

. ./govc_env

govc datastore.disk.create -ds Datastore -size 2G data.vmdk
