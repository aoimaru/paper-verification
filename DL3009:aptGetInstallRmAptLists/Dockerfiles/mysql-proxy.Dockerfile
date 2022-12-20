FROM debian:jessie

RUN set -xe \
    && apt-get update \
    && apt-get install -y mysql-proxy \
    && rm -rf /var/lib/apt/lists/*