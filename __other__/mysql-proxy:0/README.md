### paper-verification

```bash
RUN set -xe \
    && apt-get update \
    && apt-get install -y mysql-proxy \
    && rm -rf /var/lib/apt/lists/*
```
* vimagick/mysql-proxy:0 Levenshtein delete:1 replace:1 insert:1
```bash

mysql-proxy:0        0.0 0.0
mediagoblin:0        0.25 7.25
discuz:0             0.4 2.0
zoneminder:0         0.4 2.6
opencart:1           0.4 2.6
joomla:0             0.4 2.8
vnstat:0             0.4 2.8
phpbb:1              0.4 3.0
mantisbt:1           0.4 3.8
prestashop:1         0.4 4.6

```
* vimagick/mysql-proxy:0 Levenshtein delete:2 replace:2 insert:1
```bash
mysql-proxy:0        0.0 0.0
mediagoblin:0        0.5 7.25
discuz:0             0.6 2.0
zoneminder:0         0.6 2.6
opencart:1           0.6 2.6
joomla:0             0.6 2.8
vnstat:0             0.6 2.8
phpbb:1              0.6 3.0
mantisbt:1           0.6 3.8
prestashop:1         0.6 4.6
```

* vimagick/mysql-proxy:0 Levenshtein delete:3 replace:3 insert:1
```bash
mysql-proxy:0        0.0 0.0
mediagoblin:0        0.75 7.25
discuz:0             0.8 2.0
zoneminder:0         0.8 2.6
opencart:1           0.8 2.6
joomla:0             0.8 2.8
vnstat:0             0.8 2.8
phpbb:1              0.8 3.0
mantisbt:1           0.8 3.8
prestashop:1         0.8 4.6
```

* vimagick/mysql-proxy:0 Jaro Winkler
```bash

mysql-proxy:0        1.0 0.0
mediagoblin:0        0.8666666666666667 7.25
discuz:0             0.8266666666666667 2.0
opencart:1           0.8266666666666667 2.6
joomla:0             0.8266666666666667 2.8
phpbb:1              0.8266666666666667 3.0
prestashop:1         0.8266666666666667 4.6
pure-ftpd:0          0.8 1.6666666666666667
proxyhub:0           0.75 5.0
vnstat:0             0.7066666666666667 2.8
```

