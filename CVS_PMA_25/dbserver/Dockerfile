FROM mariadb:10.11

COPY mysqld.cnf /etc/mysql/mariadb.conf.d/

COPY ssl/ /etc/mysql/ssl/

RUN chmod 600 /etc/mysql/ssl/*.pem && \
    chmod 644 /etc/mysql/mariadb.conf.d/*.cnf && \
    chown -R mysql:mysql /etc/mysql/ssl/

EXPOSE 3306