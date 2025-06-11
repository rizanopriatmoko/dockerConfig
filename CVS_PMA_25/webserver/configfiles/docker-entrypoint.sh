#!/bin/bash
DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_NAME=$(cat /run/secrets/db_name)

sed -i "s/IDENTIFIED BY '.*'/IDENTIFIED BY '$DB_PASSWORD'/" /docker-entrypoint-initdb.d/*.sql
sed -i "s/TO '.*'@/TO '$DB_USER'@/" /docker-entrypoint-initdb.d/*.sql
sed -i "s/USE .*;/USE $DB_NAME;/" /docker-entrypoint-initdb.d/*.sql

exec /usr/local/bin/docker-entrypoint.sh "$@"
# Create runtime directories with correct permissions
mkdir -p /run/php-fpm /var/lib/php/session /var/log/php-fpm
chown -R nginx:nginx /run/php-fpm /var/lib/php/session /var/log/php-fpm

# Start services as root but drop privileges through configs
nginx -t && php-fpm -t  # Verify configs
php-fpm --daemonize && exec nginx -g "daemon off;"