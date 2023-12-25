FROM debian:buster

RUN apt-get update -y && apt-get install -y nginx openssl

COPY ./tools/setup.sh /

RUN chmod +x /setup.sh

CMD ["/setup.sh"]