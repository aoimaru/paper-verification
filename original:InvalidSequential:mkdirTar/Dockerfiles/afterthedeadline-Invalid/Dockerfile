FROM openjdk:8-alpine
LABEL maintainer "Jessie Frazelle <jess@linux.com>"

RUN apk add --no-cache \
	ca-certificates \
	curl \
	tar \
    tree

ENV LANG C.UTF-8
# https://open.afterthedeadline.com/download/download-source-code/
ENV ATD_VERSION 081310

RUN curl -sSL "http://www.polishmywriting.com/download/atd_distribution${ATD_VERSION}.tgz" -o /tmp/atd.tar.gz \
	&& tar -xzf /tmp/atd.tar.gz -C /usr/src/atd --strip-components 1 \
	&& mkdir -p /usr/src/atd \
	&& rm /tmp/atd.tar.gz*

CMD ["tree"]