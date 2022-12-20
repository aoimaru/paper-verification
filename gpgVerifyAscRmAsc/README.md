## gpgVerifyAscRmAsc

* bash Best-Practice?              -> Yes
* Immediate Violation Consequences -> Space Wastage
* Future Violation Consequences    -> Increased attack surface
* Gold Set Confidence              -> 100.00%

### gold/100644861884e21cc1e1aa878b21042b810f04f4:2
* 実際のDockerfile
```bash
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
	&& npm install -g npm@1.4.28 \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear
```
* ルール[gpgVerifyAscRmAsc]に違反しているDockerfile
```bash
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 
```

### Levenshteinで検索を行った結果
パラメータ: Levenshtein delete:1 replace:1 insert:1 
* gold/9df5821e4057dff4a370a6158d88b049bd6337e6:2 ---> 0.3333333333333333
```bash
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear
```
* gold/687325d5da6f523881e31dd91523ecb56f6b1f61:5 ---> 0.9166666666666666
```bash
RUN set -eux; \
	curl -fL -o owncloud.tar.bz2 "https://download.owncloud.org/community/owncloud-${OWNCLOUD_VERSION}.tar.bz2"; \
	curl -fL -o owncloud.tar.bz2.asc "https://download.owncloud.org/community/owncloud-${OWNCLOUD_VERSION}.tar.bz2.asc"; \
	echo "$OWNCLOUD_SHA256 *owncloud.tar.bz2" | sha256sum -c -; \
	export GNUPGHOME="$(mktemp -d)"; \
# gpg key from https://owncloud.org/owncloud.asc
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys E3036906AD9F30807351FAC32D5D5E97F6978A26; \
	gpg --batch --verify owncloud.tar.bz2.asc owncloud.tar.bz2; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -r "$GNUPGHOME" owncloud.tar.bz2.asc; \
	tar -xjf owncloud.tar.bz2 -C /usr/src/; \
	rm owncloud.tar.bz2
```