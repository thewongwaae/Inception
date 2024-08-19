FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server

# Copy setup script to container
COPY conf/mdb-conf.sh /
RUN chmod +x /mdb-conf.sh

EXPOSE 3306

# Since the script is now in container root, just specify it is in root (.)
ENTRYPOINT ["./mdb-conf.sh"]