FROM alpine:latest

RUN set -xe \
    && apk add -U curl \
    && curl -sSL $WEBGOAT_URL > webgoat.jar \
    && apk del curl 
    # && rm -rf /var/cache/apk/*