# FROM buildpack-deps
FROM ubuntu

RUN apt-get update && apt-get install -y \
		ca-certificates \
		curl \
        tree

# verify gpg and sha256: http://nodejs.org/dist/v0.10.30/SHASUMS256.txt.asc
# gpg: aka "Timothy J Fontaine (Work) <tj.fontaine@joyent.com>"
# RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 173d2b9ba4cbfb45a2472029f2904f965081498381a34d01b3889a850238de2b

ENV NODE_VERSION 0.11.14
ENV NPM_VERSION 2.1.18

# RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
RUN curl -SLO "http://nodejs.org/dist/v0.10.30/node-v0.10.30-linux-x64.tar.gz" \
	&& curl -SLO "http://nodejs.org/dist/v0.10.30/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v0.10.30-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v0.10.30-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v0.10.30-linux-x64.tar.gz" SHASUMS256.txt.asc \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear

CMD [ "node" ]
