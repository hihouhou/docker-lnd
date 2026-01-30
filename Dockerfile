#
# Lnd Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV GOROOT=/usr/local/go
ENV GOPATH=/opt/lnd
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH
ENV GO_VERSION=1.23.0
ENV LND_VERSION=v0.20.0-beta

# Update & install packages
RUN apt-get update && \
    apt-get install -y wget git make build-essential

# Get go
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -xvf go${GO_VERSION}.linux-amd64.tar.gz && \
    mv go /usr/local

WORKDIR /opt/lnd

# Get lnd from github
RUN mkdir -p $GOPATH/src/github.com/lightningnetwork/lnd && \
    cd $GOPATH/src/github.com/lightningnetwork/lnd && \
    wget https://github.com/lightningnetwork/lnd/archive/${LND_VERSION}.tar.gz && \
    tar --strip-components=1 -xf ${LND_VERSION}.tar.gz && \
    rm ${LND_VERSION}.tar.gz && \
    make && make install tags="signrpc walletrpc chainrpc invoicesrpc monitoring"

CMD lnd $OPTIONS
