## rmRecurisveAfterMktempD

* bash Best-Practice?              -> No
* Immediate Violation Consequences -> Build failure
* Future Violation Consequences    -> N/A
* Gold Set Confidence              -> 100.00%

### vimagick/kafka-manager:1
* 実際のDockerfile
```bash
RUN set -xe \
    && mkdir src \
    && curl -sSL https://github.com/yahoo/kafka-manager/archive/$KAFKA_MANAGER_VERSION.tar.gz | tar xz --strip 1 -C src \
    && cd src \
    && sbt clean universal:packageZipTarball \
    && cd .. \
    && tar xzf src/target/universal/kafka-manager-$KAFKA_MANAGER_VERSION.tgz --strip 1 \
    && rm -rf src
```
* ルール[rmRecurisveAfterMktempD]に違反しているDockerfile
```bash
RUN set -xe \
    && mkdir src \
    && curl -sSL https://github.com/yahoo/kafka-manager/archive/$KAFKA_MANAGER_VERSION.tar.gz | tar xz --strip 1 -C src \
    && cd src \
    && sbt clean universal:packageZipTarball \
    && cd .. \
    && tar xzf src/target/universal/kafka-manager-$KAFKA_MANAGER_VERSION.tgz --strip 1 
```

### Levenshteinで検索を行った結果
0.33333333...は7個検出 \
パラメータ: Levenshtein delete:1 replace:1 insert:1 
* vimagick/twemproxy:0 ---> 0.6363636363636364
```bash
RUN set -xe \
    && apk --no-cache add -t TMP alpine-sdk autoconf automake curl libtool tar \
    && mkdir -p conf logs src \
    && curl -sSL ${TWEMPROXY_URL} | tar xz --strip 1 -C src \
    && cd src \
    && autoreconf -fvi \
    && CFLAGS="-O3" ./configure \
    && make install \
    && nutcracker --version \
    && cd .. \
    && rm -rf src \
    && apk del TMP
```
* gold/4ee640d195f408deedaa8080d7e4c78438e1b9e1:0 ---> 0.3333333333333333
```bash
RUN set -xe \
    && apk add --no-cache build-base openssl \
    && wget https://github.com/jech/polipo/archive/master.zip -O polipo.zip \
    && unzip polipo.zip \
    && cd polipo-master \
    && make \
    && install polipo /usr/local/bin/ \
    && cd .. \
    && rm -rf polipo.zip polipo-master \
    && mkdir -p /usr/share/polipo/www /var/cache/polipo \
    && apk del build-base openssl
```