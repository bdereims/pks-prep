#!/bin/sh

sed -i "s/###SERVER###/${HOSTNAME}/" /var/www/html/bdereims/index.html

nginx -g 'daemon off;'
