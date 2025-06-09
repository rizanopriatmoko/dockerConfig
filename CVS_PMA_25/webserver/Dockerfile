# Webserver Dockerfile

FROM rockylinux:9-minimal

RUN dnf update -y && \
    dnf install -y \
    nginx-1.20.1 \
    php-fpm-8.0 \
    php-mysqlnd-8.0 && \
    dnf clean all && \
	rm -rf /var/cache/dnf/*

# create service user
RUN useradd -r -s /sbin/nologin nginx && \
    useradd -r -s /sbin/nologin php-fpm


COPY --chown=nginx:nginx webfiles/ /usr/share/nginx/html

COPY configfiles/nginx.conf     /etc/nginx/nginx.conf
COPY configfiles/php.ini        /etc/php.ini
COPY configfiles/www.conf       /etc/php-fpm.d/www.conf
COPY configfiles/php-fpm.conf   /etc/nginx/conf.d/php-fpm.conf
COPY configfiles/docker-entrypoint.sh /

RUN rm -f /usr/share/nginx/html/index.html /usr/share/nginx/html/nginx-logo.png /usr/share/nginx/html/poweredby.png
RUN RUN chmod -R 755 /usr/share/nginx/html && \ 
    chmod +x /docker-entrypoint.sh && \ 
    chown -R nginx:nginx /usr/share/nginx/html

# Configure security headers
RUN echo "server_tokens off;" >> /etc/nginx/nginx.conf && \
    echo "add_header X-Frame-Options SAMEORIGIN;" >> /etc/nginx/nginx.conf && \
    echo "add_header X-Content-Type-Options nosniff;" >> /etc/nginx/nginx.conf

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

EXPOSE 80
# EXPOSE 8004
# EXPOSE 2375
# EXPOSE 22

USER nginx

ENTRYPOINT ["/docker-entrypoint.sh"]
