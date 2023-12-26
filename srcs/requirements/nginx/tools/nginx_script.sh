#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out $CERTS_ -subj "/C=MY/L=MY/O=42 Malaysia/OU=student/CN=hwong.42kl.my"

echo "
server {
	listen 443 ssl;
	listen [::]:443 ssl;
	server_name www.$DOMAIN_NAME $DOMAIN_NAME;

	ssl_certificate $CERTS_;
	ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
	ssl_protocols TLSv1.3;

	index index.html;
	root /var/www/html;

	location / {
		try_files $uri $uri/ =404;
	}
}" > /etc/nginx/sites-available/default

nginx -g "daemon off;"