#!/bin/bash

. ./govc_env

govc datastore.disk.create -ds Datastore -size 2G data.vmdk
