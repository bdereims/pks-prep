FROM alpine

ARG WEBPATH 

RUN apk update && apk add nginx && adduser -D -g 'www' www && mkdir /www && \
	chown -R www:www /var/lib/nginx && chown -R www:www /www && \
	mkdir -p /run/nginx

COPY nginx/startup.sh /
RUN chmod ugo+rwx /startup.sh && mkdir -p /var/www/html/${WEBPATH}
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY html/* /var/www/html/${WEBPATH}/

CMD ["/startup.sh"]
