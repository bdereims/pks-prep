FROM alpine

RUN apk update && apk add nginx && adduser -D -g 'www' www && mkdir /www && \
	chown -R www:www /var/lib/nginx && chown -R www:www /www && \
	mkdir -p /run/nginx

COPY nginx/startup.sh /
COPY nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html/avalanche
COPY html/* /var/www/html/avalanche/

#CMD ["nginx", "-g", "daemon off;"]
CMD ["/startup.sh"]
