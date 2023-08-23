FROM ubuntu:22.04

LABEL maintainer="Benjamin Schmitz <dev@benjamin-schmitz.org>"
LABEL description="Ubuntu with Python 3 and Node.js"

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-is-python3 python3-pip nodejs npm
RUN rm -rf /var/lib/apt/lists/*
