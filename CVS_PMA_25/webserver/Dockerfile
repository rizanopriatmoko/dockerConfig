# Webserver Dockerfile
FROM rockylinux:9

RUN dnf update -y && \
    dnf install -y nginx php-fpm php-mysqlnd && \
    dnf clean all && \
    rm -rf /var/log/httpd

# create service user
RUN id -u nginx 2>/dev/null || useradd -r -s /sbin/nologin nginx && \
    id -u php-fpm 2>/dev/null || useradd -r -s /sbin/nologin php-fpm

COPY webfiles/ /usr/share/nginx/html
COPY configfiles/ca.pem /etc/ssl/ca.pem
COPY configfiles/nginx.conf     /etc/nginx/nginx.conf
COPY configfiles/php.ini        /etc/php.ini
COPY configfiles/www.conf       /etc/php-fpm.d/www.conf
COPY configfiles/docker-entrypoint.sh /

RUN rm -f /usr/share/nginx/html/index.html /usr/share/nginx/html/nginx-logo.png /usr/share/nginx/html/poweredby.png
RUN chmod 755 /usr/share/nginx/html && \
    find /usr/share/nginx/html -type d -exec chmod 755 {} \; && \
    find /usr/share/nginx/html -type f -exec chmod 644 {} \;

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
