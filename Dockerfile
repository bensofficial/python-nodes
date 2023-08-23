FROM ubuntu:22.04

LABEL maintainer="Benjamin Schmitz <dev@benjamin-schmitz.org>"
LABEL description="Ubuntu with Python 3 and Node.js"

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-is-python3 python3-pip


# c.f. https://stackoverflow.com/a/28390848
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 16

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.39.5/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN rm -rf /var/lib/apt/lists/*
