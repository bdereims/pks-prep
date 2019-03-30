#!/bin/bash

. ./env

TZ=America/Las_Vegas

DB=web.txt

cp /dev/null $DB 

for LINE in {1..1000}
do
	NAME=$( ./petname.sh )
	DATE=$( date +%c )
	printf "${LINE}-${NAME}\t${DATE}\n" >> ${DB} 
done

mysqlimport -h ${HOST} -u root -pVMware1! --local nginx ${DB} 
