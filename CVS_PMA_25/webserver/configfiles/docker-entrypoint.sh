#!/bin/bash

# Create runtime directories with correct permissions
mkdir -p /run/php-fpm /var/lib/php/session /var/log/php-fpm
chown -R nginx:nginx /run/php-fpm /var/lib/php/session /var/log/php-fpm

# Start services as root but drop privileges through configs
nginx -t && php-fpm -t  # Verify configs
php-fpm --daemonize && exec nginx -g "daemon off;"