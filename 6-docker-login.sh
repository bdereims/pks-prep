#!/bin/bash

. ./env

HARBOR=harbor.pks-reg.gv
docker login ${HARBOR} -u ${ADMIN} -p ${ADMIN_PASSWORD}
