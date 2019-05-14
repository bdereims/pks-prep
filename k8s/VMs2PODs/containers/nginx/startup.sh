#!/bin/sh

sed -i "s/###SERVER###/${HOSTNAME}/" /var/www/html/vmware/index.html

nginx -g 'daemon off;'
