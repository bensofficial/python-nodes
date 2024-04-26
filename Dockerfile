FROM ubuntu:24.04

LABEL maintainer="Benjamin Schmitz <dev@benjamin-schmitz.org>"
LABEL description="Ubuntu with Python 3, Node.js, and some preinstalled packages."
WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-is-python3 python3-pip curl git libglib2.0-0 libnss3 libnspr4 libdbus-1-3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libatspi2.0-0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libdrm2 libxkbcommon0 libpango-1.0-0 libcairo2 liboss4-salsa-asound2 libimage-exiftool-perl

COPY requirements.txt requirements.txt
RUN pip install --break-system-packages -r requirements.txt

ENV NODE_VERSION v16
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.5/install.sh | bash

COPY package.json /app
COPY package-lock.json /app
RUN export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default && \
    npm ci && \
    npx playwright install chromium

RUN rm -rf /var/lib/apt/lists/*
