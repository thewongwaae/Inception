FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

# Generate self-signed SSL certificate
# -x509 ~ specifies self-signed instead of certificate request
# -nodes ~ skip encryption
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MY/ST=KL/L=KL/O=42/OU=42/CN=hwong.42.fr"

COPY conf/nginx.conf /etc/nginx/
COPY conf/default /etc/nginx/sites-enabled/default

RUN mkdir -p /var/www/wordpress
# Change owner of the Wordpress directory to www-data
RUN chown -R www-data:www-data /var/www/wordpress

EXPOSE 443

# Run in foreground
CMD ["nginx", "-g", "daemon off;"]