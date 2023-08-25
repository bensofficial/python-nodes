FROM ubuntu:22.04

LABEL maintainer="Benjamin Schmitz <dev@benjamin-schmitz.org>"
LABEL description="Ubuntu with Python 3, Node.js, and some preinstalled packages."

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-is-python3 python3-pip curl git

RUN pip install mkdocs
RUN pip install git+https://github.com/oprypin/mkdocs-print-site-plugin.git@md15

ENV NODE_VERSION v16
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.5/install.sh | bash

WORKDIR /app
COPY package.json /app
COPY package-lock.json /app

RUN export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default && \
    npm ci && \
    npx playwright install --with-deps chromium

RUN rm -rf /var/lib/apt/lists/*
