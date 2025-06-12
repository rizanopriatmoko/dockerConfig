#!/bin/bash
DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_NAME=$(cat /run/secrets/db_name)

# Create runtime directories with correct permissions
mkdir -p /run/php-fpm /var/lib/php/session /var/log/php-fpm
chown -R nginx:nginx /run/php-fpm /var/lib/php/session /var/log/php-fpm

nginx -t && php-fpm -t  # Verify configs
php-fpm --daemonize && exec nginx -g "daemon off;"