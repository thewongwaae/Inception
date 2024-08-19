#!/bin/bash

# CURL the wordpress client interface PHP archive file
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress
chmod -R 777 /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress

#----------check connection to mariadb----------#
ping_mariadb_container() {
    nc -zv mariadb 3306 > /dev/null # Use NetCat to prod the mariadb container through 3306
    return $?
}
start_time=$(date +%s) # get the current time in seconds
end_time=$((start_time + 20)) # set the end time to 20 seconds after the start time
while [ $(date +%s) -lt $end_time ]; do # loop until the current time is greater than the end time
    ping_mariadb_container
    if [ $? -eq 0 ]; then # Check last exit status, if 0, success
        echo "[========MARIADB IS UP AND RUNNING========]"
        break
    else
        echo "[========WAITING FOR MARIADB TO START...========]"
        sleep 1
    fi
done

if [ $(date +%s) -ge $end_time ]; then
    echo "[========MARIADB IS NOT RESPONDING========]"
fi

#----------wp installation----------#
wp core download --allow-root
wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --allow-root

#----------php config----------#
# change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php # Create a directory for php-fpm
/usr/sbin/php-fpm7.4 -F # Start php-fpm service in the foreground