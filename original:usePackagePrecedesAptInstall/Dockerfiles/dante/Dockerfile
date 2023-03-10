#
# Dockerfile for dante
#

FROM debian:bullseye
MAINTAINER EasyPi Software Foundation


ENV DANTE_VER=1.4.3
ENV DANTE_URL=https://www.inet.no/dante/files/dante-$DANTE_VER.tar.gz
ENV DANTE_SHA1=1e264ec532774324b5508ba5f2ad226d479b4977
ENV DANTE_FILE=dante.tar.gz
ENV DANTE_TEMP=dante
ENV DANTE_DEPS="build-essential curl"

RUN set -xe \
    && apt-get update \
    && apt-get install -y $DANTE_DEPS tree \
    && mkdir $DANTE_TEMP \
        && cd $DANTE_TEMP \
        && curl -sSL $DANTE_URL -o $DANTE_FILE \
        && echo "$DANTE_SHA1 *$DANTE_FILE" | sha1sum -c \
        && tar xzf $DANTE_FILE --strip 1 \
        && ./configure \
        && make install \
        && cd .. \
        && rm -rf $DANTE_TEMP \
    && apt-get purge -y --auto-remove $DANTE_DEPS \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /
CMD [ "tree" ]
