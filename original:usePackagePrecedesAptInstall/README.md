## original:usePackagePrecedesAptInstall

* bash Best-Practice?              -> ?
* Immediate Violation Consequences -> Build failure
* Future Violation Consequences    -> N/A
* Gold Set Confidence              -> ?

### gold/4ee640d195f408deedaa8080d7e4c78438e1b9e1:0
* 実際のDockerfile
```bash
RUN set -xe \
    && apt-get update \
    && apt-get install -y $DANTE_DEPS \
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
```
* ルール[original:usePackagePrecedesAptInstall]に違反しているDockerfile
```bash
RUN mkdir $DANTE_TEMP \
        && cd $DANTE_TEMP \
        && curl -sSL $DANTE_URL -o $DANTE_FILE \
        && echo "$DANTE_SHA1 *$DANTE_FILE" | sha1sum -c \
        && tar xzf $DANTE_FILE --strip 1 \
        && ./configure \
        && make install \
        && cd .. \
        && rm -rf $DANTE_TEMP 
```
この記述の場合, curlとtarをインストールしていないのにも関わらず使用しようとしている \
実際のエラーメッセージ
```bash
~/D/p/o/D/dante-error ❯❯❯ docker build -t dante-error:v1.0.0 .
[+] Building 1.0s (5/5) FINISHED                                                                                                                                          
 => [internal] load build definition from Dockerfile                                                                                                                 0.0s
 => => transferring dockerfile: 697B                                                                                                                                 0.0s
 => [internal] load .dockerignore                                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/debian:bullseye                                                                                                   0.7s
 => CACHED [1/2] FROM docker.io/library/debian:bullseye@sha256:a288aa7ad0e4d443e86843972c25a02f99e9ad6ee589dd764895b2c3f5a8340b                                      0.0s
 => ERROR [2/2] RUN mkdir dante         && cd dante         && curl -sSL https://www.inet.no/dante/files/dante-1.4.3.tar.gz -o dante.tar.gz         && echo "1e264e  0.2s
------
 > [2/2] RUN mkdir dante         && cd dante         && curl -sSL https://www.inet.no/dante/files/dante-1.4.3.tar.gz -o dante.tar.gz         && echo "1e264ec532774324b5508ba5f2ad226d479b4977 *dante.tar.gz" | sha1sum -c         && tar xzf dante.tar.gz --strip 1         && ./configure         && make install         && cd ..         && rm -rf dante WORKDIR /:
#5 0.190 /bin/sh: 1: curl: not found
------
executor failed running [/bin/sh -c mkdir $DANTE_TEMP         && cd $DANTE_TEMP         && curl -sSL $DANTE_URL -o $DANTE_FILE         && echo "$DANTE_SHA1 *$DANTE_FILE" | sha1sum -c         && tar xzf $DANTE_FILE --strip 1         && ./configure         && make install         && cd ..         && rm -rf $DANTE_TEMP WORKDIR /]: exit code: 127
```

### Levenshteinで検索を行った結果
パラメータ: Levenshtein delete:1 replace:1 insert:1 
* vimagick/chinadns:0 ---> 0.7142857142857143
```bash
RUN apt-get update \
    && apt-get install -y build-essential curl dnsmasq supervisor \
    && mkdir chinadns \
        && cd chinadns \
        && curl -sSL ${DNS_URL} -o ${DNS_FILE} \
        && echo "${DNS_MD5} ${DNS_FILE}" | md5sum -c \
        && tar xzf ${DNS_FILE} --strip 1 \
        && ./configure \
        && make install \
        && cd .. \
        && rm -rf chinadns \
    && apt-get remove -y build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
```
* vimagick/libev-arm:0 ---> 0.7272727272727273
```bash
RUN set -ex \
    && apk add --update $SS_DEP \
    && curl -sSL $SS_URL | tar xz \
    && cd $SS_DIR \
        && ./configure \
        && make install \
        && cd .. \
        && rm -rf $SS_DIR \
    && apk del --purge $SS_DEP \
    && rm -rf /var/cache/apk/*
```