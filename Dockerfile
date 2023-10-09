FROM ubuntu:22.04

ENV TZ=Asia/Shanghai
RUN set -ex \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update -yq \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq install nodejs netselect-apt rsync curl \
    && npm install -g yarn tyarn \
    && rm -rf /var/lib/apt/lists/*
