## DL3009
### Delete the apt-get lists after installing something.

### vimagick/mysql-proxy:0 
* 実際のDockerfile
```bash
RUN set -xe \
    && apt-get update \
    && apt-get install -y mysql-proxy \
    && rm -rf /var/lib/apt/lists/*
```
* DL3009に違反しているDockerfile
```bash
RUN set -xe \
    && apt-get update \
    && apt-get install -y mysql-proxy \

$ docker run --rm -i hadolint/hadolint < Dockerfile

-:3 DL3008 warning: Pin versions in apt get install. Instead of `apt-get install <package>` use `apt-get install <package>=<version>`
-:3 DL3009 info: Delete the apt-get lists after installing something
-:3 DL3015 info: Avoid additional packages by specifying `--no-install-recommends`
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

* mediagoblin:0 ---> cost: 0.5
```bash
RUN set -xe \
    && apt-get update \
    && apt-get install -y automake \
                          gir1.2-gst-plugins-base-1.0 \
                          gir1.2-gstreamer-1.0 \
                          git-core \
                          gstreamer1.0-libav \
                          gstreamer1.0-plugins-bad \
                          gstreamer1.0-plugins-base \
                          gstreamer1.0-plugins-good \
                          gstreamer1.0-plugins-ugly \
                          gstreamer1.0-tools \
                          libasound2-dev \
                          libgstreamer-plugins-base1.0-dev \
                          libsndfile1-dev \
                          nginx \
                          nodejs-legacy \
                          npm \
                          poppler-utils \
                          python \
                          python-dev \
                          python-gi \
                          python-gst-1.0 \
                          python-gst-1.0 \
                          python-imaging \
                          python-lxml \
                          python-numpy \
                          python-scipy \
                          python-virtualenv \
                          python3-gi \
                          sudo \
    && rm -rf /var/lib/apt/lists/*


$ docker run --rm -i hadolint/hadolint < Dockerfile

-:3 DL3008 warning: Pin versions in apt get install. Instead of `apt-get install <package>` use `apt-get install <package>=<version>`
-:3 DL3015 info: Avoid additional packages by specifying `--no-install-recommends`
```

* discuz:0 ---> cost: 0.6
```bash
RUN set -xe \
    && echo 'deb http://http.debian.net/debian jessie-backports main' >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y fcgiwrap \
                                                  ffmpeg \
                                                  nginx \
                                                  php5-fpm \
                                                  zoneminder \
    && rm -rf /var/lib/apt/lists/*
```