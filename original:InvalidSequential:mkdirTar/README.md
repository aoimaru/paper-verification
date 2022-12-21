## original:InvalidSequential:mkdirTar

### jessfraz/afterthedeadline:1
* 実際のDockerfile
```bash
RUN curl -sSL "http://www.polishmywriting.com/download/atd_distribution${ATD_VERSION}.tgz" -o /tmp/atd.tar.gz \
	&& mkdir -p /usr/src/atd \
	&& tar -xzf /tmp/atd.tar.gz -C /usr/src/atd --strip-components 1 \
	&& rm /tmp/atd.tar.gz*

$ docker build -t afterthedeadline:v0.0.1 .
--> ビルドに成功
```

* ルール[original:InvalidSequential:mkdirTar]に違反しているDockerfile
```bash
RUN curl -sSL "http://www.polishmywriting.com/download/atd_distribution${ATD_VERSION}.tgz" -o /tmp/atd.tar.gz \
	&& tar -xzf /tmp/atd.tar.gz -C /usr/src/atd --strip-components 1 \
	&& mkdir -p /usr/src/atd \
	&& rm /tmp/atd.tar.gz*

~/D/p/o/D/afterthedeadline-Invalid ❯❯❯ docker build -t afterthedeadline:invalid .
[+] Building 341.7s (6/6) FINISHED                                                                                                                                                          
 => [internal] load build definition from Dockerfile                                                                                                                                   0.0s
 => => transferring dockerfile: 541B                                                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                                                        0.0s
 => [internal] load metadata for docker.io/library/openjdk:8-alpine                                                                                                                    5.0s
 => [1/3] FROM docker.io/library/openjdk:8-alpine@sha256:94792824df2df33402f201713f932b58cb9de94a0cd524164a0f2283343547b3                                                              0.0s
 => CACHED [2/3] RUN apk add --no-cache  ca-certificates  curl  tar     tree                                                                                                           0.0s
 => ERROR [3/3] RUN curl -sSL "http://www.polishmywriting.com/download/atd_distribution081310.tgz" -o /tmp/atd.tar.gz  && tar -xzf /tmp/atd.tar.gz -C /usr/src/atd --strip-componen  336.5s
------
 > [3/3] RUN curl -sSL "http://www.polishmywriting.com/download/atd_distribution081310.tgz" -o /tmp/atd.tar.gz  && tar -xzf /tmp/atd.tar.gz -C /usr/src/atd --strip-components 1        && mkdir -p /usr/src/atd    && rm /tmp/atd.tar.gz*:
#5 336.4 tar: /usr/src/atd: Cannot open: No such file or directory
#5 336.4 tar: Error is not recoverable: exiting now
------
executor failed running [/bin/sh -c curl -sSL "http://www.polishmywriting.com/download/atd_distribution${ATD_VERSION}.tgz" -o /tmp/atd.tar.gz   && tar -xzf /tmp/atd.tar.gz -C /usr/src/atd --strip-components 1    && mkdir -p /usr/src/atd        && rm /tmp/atd.tar.gz*]: exit code: 2

```

### Levenshteinで検索を行った結果
パラメータ: Levenshtein delete:1 replace:1 insert:1 
* znc:2 ---> 0.8461538461538461
```bash
RUN set -x \
	&& apk add --no-cache --virtual .build-deps \
		build-base \
		curl \
		libressl-dev \
		perl-dev \
		tar \
	&& curl -sSL "http://znc.in/releases/znc-${ZNC_VERSION}.tar.gz" -o /tmp/znc.tar.gz \
	&& mkdir -p /usr/src/znc \
	&& tar -xzf /tmp/znc.tar.gz -C /usr/src/znc --strip-components 1 \
	&& rm /tmp/znc.tar.gz* \
	&& ( \
		cd /usr/src/znc \
		&& ./configure \
		&& make -j8 \
		&& make install \
	) \
	&& rm -rf /usr/src/znc \
	&& runDeps="$( \
		scanelf --needed --nobanner --recursive /usr \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)" \
	&& apk add --no-cache --virtual .irssi-rundeps $runDeps \
	&& apk del .build-deps

$ docker build -t znc:v0.0.1 .
--> ビルドに成功
```