#!/bin/bash
#bdereims@vmware.com

openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout cert.key -out cert.crt
