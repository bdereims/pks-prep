FROM alpine

RUN apk update && apk add nginx && adduser -D -g 'www' www && mkdir /www && \
	chown -R www:www /var/lib/nginx && chown -R www:www /www && \
	mkdir -p /run/nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY list.php /var/www/html/list.php

CMD ["nginx", "-g", "daemon off;"]
