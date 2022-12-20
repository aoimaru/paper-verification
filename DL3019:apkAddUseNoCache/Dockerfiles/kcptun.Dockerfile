FROM alpine:3

RUN set -xe \
    && apk add --no-cache curl \
    && curl -sSL ${KCPTUN_URL} | tar xz -C /usr/local/bin \
    && apk del curl