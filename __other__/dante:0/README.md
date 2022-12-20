### paper-verification
```bash
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

```
* vimagick/dante:0 Levenshtein delete:1 replace:1 insert:1
```bash
dante:0              0.0 0.0
chinadns:0           0.6428571428571429 1.2857142857142858
libev-arm:0          0.7142857142857143 2.5
twemproxy:0          0.7142857142857143 4.0
rslsync:0            0.7857142857142857 2.9285714285714284
shoutcast:0          0.7857142857142857 3.0
h2o:0                0.7857142857142857 3.142857142857143
i2pd:0               0.7857142857142857 3.2142857142857144
ambari:1             0.7857142857142857 3.2142857142857144
ot-recorder:0        0.7857142857142857 3.2857142857142856

```
* vimagick/dante:0 Levenshtein delete:2 replace:2 insert:1
```bash
dante:0              0.0 0.0
proxyhub:9           1.0714285714285714 4.428571428571429
bro:1                1.0714285714285714 4.571428571428571
tabula:1             1.0714285714285714 4.642857142857143
webkit:0             1.0714285714285714 4.642857142857143
ansible:1            1.0714285714285714 4.642857142857143
webhook:2            1.0714285714285714 4.714285714285714
webkit:1             1.0714285714285714 4.714285714285714
webkit:4             1.0714285714285714 4.714285714285714
ludwig:0             1.0714285714285714 4.714285714285714
```

* vimagick/dante:0 Levenshtein delete:3 replace:3 insert:1
```bash
dante:0              0.0 0.0
proxyhub:9           1.0714285714285714 4.428571428571429
bro:1                1.0714285714285714 4.571428571428571
tabula:1             1.0714285714285714 4.642857142857143
webkit:0             1.0714285714285714 4.642857142857143
ansible:1            1.0714285714285714 4.642857142857143
webhook:2            1.0714285714285714 4.714285714285714
webkit:1             1.0714285714285714 4.714285714285714
webkit:4             1.0714285714285714 4.714285714285714
ludwig:0             1.0714285714285714 4.714285714285714
```

* vimagick/dante:0 Jaro Winkler
```bash
dante:0              1.0 0.0
magento:2            0.7857142857142857 4.571428571428571
bro:1                0.6904761904761904 4.571428571428571
proxyhub:0           0.6904761904761904 4.857142857142857
ambari:1             0.6761904761904762 3.2142857142857144
ot-recorder:0        0.6495238095238095 3.2857142857142856
mantisbt:3           0.6428571428571428 4.571428571428571
mysql-proxy:0        0.638095238095238 3.5
mediagoblin:0        0.638095238095238 4.357142857142857
scrapyd:0            0.6317460317460317 9.142857142857142
```

* vimagick/dante:0 Levenshtein delete:1 replace:1 insert:1 dummy:data
```bash
dante:0              0.14285714285714285 0.6428571428571429
chinadns:0           0.7142857142857143 1.8571428571428572
libev-arm:0          0.7142857142857143 3.0
twemproxy:0          0.7142857142857143 4.5
h2o:0                0.7857142857142857 3.7142857142857144
rinetd:0             0.7857142857142857 4.0
sslsplit:0           0.7857142857142857 4.928571428571429
shairplay-arm:0      0.7857142857142857 5.142857142857143
kismet:0             0.7857142857142857 6.285714285714286
vsftpd:0             0.8571428571428571 3.357142857142857

```


* vimagick/chinadns
```bash
RUN apt-get update \
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
    && apt-get remove -y build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
```
どちらも, sockdというデーモンを動かすためのコンテナ
```bash

~/D/b/g/obfsproxy ❯❯❯ docker run -it --rm --name dante chinadns:v0.0.1 tree /usr/local/sbin/
/usr/local/sbin/
-- sockd

0 directories, 1 file

~/D/b/g/obfsproxy ❯❯❯ docker run -it --rm --name dante dante:v0.0.1 tree /usr/local/sbin/
/usr/local/sbin/
-- sockd

0 directories, 1 file


~/D/b/g/obfsproxy ❯❯❯ docker run -it --rm --name dante dante:v0.0.1 tree /var/lib/apt/lists/
/var/lib/apt/lists/

0 directories, 0 files
~/D/b/g/obfsproxy ❯❯❯ docker run -it --rm --name dante chinadns:v0.0.1 tree /var/lib/apt/lists/
/var/lib/apt/lists/

0 directories, 0 files

```