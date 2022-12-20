FROM debian:jessie

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