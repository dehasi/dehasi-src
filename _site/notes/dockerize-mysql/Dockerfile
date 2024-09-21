FROM mysql:8 AS builder
ENV MYSQL_ROOT_PASSWORD=pass

COPY data/ /docker-entrypoint-initdb.d/

RUN sed -i 's/\(exec "$@"\)/echo skipping \1/' /usr/local/bin/docker-entrypoint.sh
RUN /usr/local/bin/docker-entrypoint.sh mysqld

FROM mysql:8
ENV MYSQL_ROOT_PASSWORD=pass22
COPY --from=builder /var/lib/mysql /var/lib/mysql
