#
# Dockerfile for mariadb
#

FROM alpine
MAINTAINER kev <noreplay@easypi.pro>

RUN set -xe \
    && apk add -U bash \
                  mariadb \
                  mariadb-client \
                  tzdata \
    && mkdir -p /run/mysqld \
    && chown mysql:mysql /run/mysqld \
    && rm -rf /var/cache/apk/* \
    && rm -rf /run/mysqld

# COPY docker-entrypoint.sh /

# VOLUME /var/lib/mysql
# ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
