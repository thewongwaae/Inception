FROM debian:buster

RUN apt-get update -y && apt-get install -y nginx openssl

COPY ./conf nginx.conf /etc/nginx/
COPY ./tools/nginx_script.sh /

RUN chmod +x /nginx_script.sh

EXPOSE 443

CMD ["/nginx_script.sh"]