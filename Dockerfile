FROM ubuntu:24.04

ARG CURL_VERSION="8.17.0"
ENV TZ=Asia/Tokyo

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y \
        wget \
        git \
        make \
        autoconf \
        automake \
        autotools-dev \
        libtool \
        pkg-config \
        libssl-dev \
        g++ \
        pkg-config \
        libev-dev \
        libssl-dev \
        libpsl-dev && \
    cd /usr/local/src/ && \
    git clone https://github.com/tatsuhiro-t/nghttp2.git && \
    cd ./nghttp2/ && \
    autoreconf -i && automake && autoconf && ./configure && make && make install && \
    cd /usr/local/src/ && \
    wget https://curl.haxx.se/download/curl-${CURL_VERSION}.tar.gz && \
    tar -zxvf ./curl-${CURL_VERSION}.tar.gz && \
    cd ./curl-${CURL_VERSION} && \
    ./configure --with-nghttp2=/usr/local --with-ssl && make && make install && ldconfig

ADD send_push.sh /var/tmp/
