FROM ubuntu:22.04

ENV TZ=Asia/Shanghai
ENV NODE_MAJOR=20

RUN set -ex \
    && apt-get update -yq \
    && apt-get install -yq ca-certificates gnupg rsync curl wget \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg \
    && sh -c 'echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" >> /etc/apt/sources.list.d/nodesource.list' \
    && apt-get update -yq \
    && DEBIAN_FRONTEND=noninteractive apt-get install nodejs -yq \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g yarn tyarn \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg \
    && sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update -yq \
    && apt-get install -yq google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-khmeros fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -r pptruser && useradd -rm -g pptruser -G audio,video pptruser

USER pptruser

WORKDIR /home/pptruser

# Install @puppeteer/browsers, puppeteer and puppeteer-core into /home/pptruser/node_modules.
RUN npm install puppeteer
