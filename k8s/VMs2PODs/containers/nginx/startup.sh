#!/bin/sh

sed -i "s/###SERVER###/${HOSTNAME}/" /var/www/html/avalanche/index.html

nginx -g 'daemon off;'
