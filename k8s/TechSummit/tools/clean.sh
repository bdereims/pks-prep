#!/bin/bash

. ./env

mysql -h ${HOST} -u root -pVMware1! <<EOF
use nginx;
delete from web where name !='toto';
EOF
