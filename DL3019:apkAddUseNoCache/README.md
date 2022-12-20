## DL3019
### Use the --no-cache switch

### vimagick/mysql-proxy:0 
* 実際のDockerfile
```bash
RUN set -xe \
    && apk add -U curl \
    && curl -sSL $WEBGOAT_URL > webgoat.jar \
    && apk del curl \
    && rm -rf /var/cache/apk/*
```
* DL3019に違反しているDockerfile
```bash
RUN set -xe \
    && apk add -U curl \
    && curl -sSL $WEBGOAT_URL > webgoat.jar \
    && apk del curl \

$ docker run --rm -i hadolint/hadolint < Dockerfile

-:1 DL3007 warning: Using latest is prone to errors if the image will ever update. Pin the version explicitly to a release tag
-:3 DL3018 warning: Pin versions in apk add. Instead of `apk add <package>` use `apk add <package>=<version>`
-:3 SC2086 info: Double quote to prevent globbing and word splitting.
-:3 DL3019 info: Use the `--no-cache` switch to avoid the need to use `--update` and remove `/var/cache/apk/*` when done installing packages
```

### Levenshteinで検索を行った結果
パラメータ: Levenshtein delete:1 replace:1 insert:1 
* mysql-proxy:0 ---> cost: 0.25
```bash
Pass

$ docker run --rm -i hadolint/hadolint < Dockerfile

-:3 DL3008 warning: Pin versions in apt get install. Instead of `apt-get install <package>` use `apt-get install <package>=<version>`
-:3 DL3015 info: Avoid additional packages by specifying `--no-install-recommends`
```
検索結果を元に, Dockerfileを修正. "&& rm -rf /var/lib/apt/lists/*"を追加 \
-:3 DL3009 info: Delete the apt-get lists after installing somethingの修正に成功

* kcptun:0 ---> cost: 0.6 
```bash

RUN set -xe \
    && apk add --no-cache curl \
    && curl -sSL ${KCPTUN_URL} | tar xz -C /usr/local/bin \
    && apk del curl

$ docker run --rm -i hadolint/hadolint < Dockerfile

-:3 DL3018 warning: Pin versions in apk add. Instead of `apk add <package>` use `apk add <package>=<version>`
-:3 DL4006 warning: Set the SHELL option -o pipefail before RUN with a pipe in it. If you are using /bin/sh in an alpine image or if your shell is symlinked to busybox then consider explicitly setting your SHELL to /bin/ash, or disable this check
-:3 SC2086 info: Double quote to prevent globbing and word splitting.
```

"&& rm -rf /var/cache/apk/*"を期待していたが, "--no-cache"を参考にできた. 棚からぼたもち \
どちらにせよ, DL3019は改修