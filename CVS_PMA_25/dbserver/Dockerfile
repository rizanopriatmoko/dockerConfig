FROM golang:1.24.4 as gosu-builder
RUN go install github.com/tianon/gosu@latest

FROM mariadb:11.8.2

COPY --from=gosu-builder /go/bin/gosu /usr/local/bin/gosu
RUN chmod +x /usr/local/bin/gosu

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        systemd=255.4-1ubuntu8.8 \
    && rm -rf /var/lib/apt/lists/*

COPY mysqld.cnf /etc/mysql/mariadb.conf.d/
COPY ssl/ /etc/mysql/ssl/

RUN chmod 600 /etc/mysql/ssl/*.pem && \
    chmod 644 /etc/mysql/mariadb.conf.d/*.cnf && \
    chown -R mysql:mysql /etc/mysql/ssl/

EXPOSE 3306