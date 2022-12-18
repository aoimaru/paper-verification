### paper-verification
* jessfraz/afterthedeadline:1 Levenshtein delete:1 replace:1 insert:1
```bash
- RUN set -xe \
-     && apk add -U curl \
-     && curl -sSL $WEBGOAT_URL > webgoat.jar \
-     && apk del curl \
-     && rm -rf /var/cache/apk/*

+ RUN set -xe \
+     && apk add -U curl \
+     && curl -sSL $WEBGOAT_URL > webgoat.jar \
+     && apk del curl \

```
* vimagick/webgoat:0[:-1] Levenshtein delete:1 replace:1 insert:1
```bash
webgoat:0            0.2 2.4
kcptun:0             0.6 2.2
openhab:0            0.6666666666666666 1.8333333333333333
privoxy:0            0.6666666666666666 4.333333333333333
python3:0            0.75 2.0
python2:0            0.75 2.0
cronicle:0           0.75 3.0
demucs:0             0.75 3.0
wafw00f:0            0.75 3.0
dnsmasq:0            0.75 3.0
```

* vimagick/webgoat:0[:-1] Levenshtein delete:2 replace:2 insert:1
```bash
webgoat:0            0.2 2.4
kcptun:0             0.6 2.2
openhab:0            0.6666666666666666 1.8333333333333333
privoxy:0            0.6666666666666666 4.333333333333333
python3:0            0.75 2.0
python2:0            0.75 2.0
cronicle:0           0.75 3.0
demucs:0             0.75 3.0
wafw00f:0            0.75 3.0
dnsmasq:0            0.75 3.0
```

* vimagick/webgoat:0[:-1] Levenshtein delete:3 replace:3 insert:1
```bash
webgoat:0            0.2 2.4
ocserv:0             1.1904761904761905 6.380952380952381
taskd:0              1.2 5.85
graphite:0           1.2105263157894737 6.473684210526316
vsftpd:1             1.2222222222222223 4.277777777777778
jsonwire-grid:0      1.2222222222222223 7.0
drone-rsync-arm:1    1.25 3.25
rsyslog:0            1.25 3.5
drone-scp-arm:0      1.25 3.5
cmus:0               1.25 3.5
```

* jessfraz/afterthedeadline:1 Jaro Winkler
```bash

webgoat:0            0.96 2.4
openhab:0            0.6499999999999999 1.8333333333333333
privoxy:0            0.6499999999999999 4.333333333333333
mpd:0                0.625 3.5
tesseract:0          0.625 3.75
errbot:1             0.625 3.75
cronicle:0           0.575 3.0
wafw00f:0            0.575 3.0
dnsmasq:0            0.575 3.0
ndscheduler:0        0.575 3.5
```