# Run znc in a container
#
# docker run --restart always -d \
#	--name znc \
#	-p 6697:6697 \
#	-v /volumes/znc:/home/user/.znc \
#	jess/znc
#
FROM alpine:latest

ENV LANG C.UTF-8

RUN set -x \
	&& apk add --no-cache \
		curl \
		tar \
        tree \
	&& curl -sSL "http://znc.in/releases/znc-1.8.2.tar.gz" -o /tmp/znc.tar.gz \
	&& mkdir -p /usr/src/znc \
	&& tar -xzf /tmp/znc.tar.gz -C /usr/src/znc --strip-components 1 \
	&& rm /tmp/znc.tar.gz* 

CMD [ "tree" ]
