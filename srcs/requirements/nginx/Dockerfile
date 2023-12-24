FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl

COPY ./tools/setup.sh /

CMD ["/setup.sh"]