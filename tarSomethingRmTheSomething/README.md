## tarSomethingRmTheSomething

* bash Best-Practice?              -> Yes
* Immediate Violation Consequences -> Space Wastage
* Future Violation Consequences    -> Increased attack surface
* Gold Set Confidence              -> 88.52%

### jessfraz/afterthedeadline:1
* 実際のDockerfile
```bash
RUN curl -sSL "http://www.polishmywriting.com/download/atd_distribution${ATD_VERSION}.tgz" -o /tmp/atd.tar.gz \
	&& mkdir -p /usr/src/atd \
	&& tar -xzf /tmp/atd.tar.gz -C /usr/src/atd --strip-components 1 \
	&& rm /tmp/atd.tar.gz*

$ docker run -it --rm --name afterthedeadline:v0.0.1 tree /tmp
/tmp

0 directories, 0 files
```

* ルール[tarSomethingRmTheSomething]に違反しているDockerfile
```bash
RUN curl -sSL "http://www.polishmywriting.com/download/atd_distribution${ATD_VERSION}.tgz" -o /tmp/atd.tar.gz \
	&& mkdir -p /usr/src/atd \
	&& tar -xzf /tmp/atd.tar.gz -C /usr/src/atd --strip-components 1 

$ docker run -it --rm --name afterthedeadline:v0.0.2 tree /tmp
/tmp
└── atd.tar.gz

0 directories, 1 file
```

### Levenshteinで検索を行った結果
パラメータ: Levenshtein delete:1 replace:1 insert:1 
* znc:2 ---> 0.9230769230769231
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
```