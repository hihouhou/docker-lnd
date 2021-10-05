#
# Lnd Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV GOROOT /usr/local/go
ENV GOPATH /opt/lnd
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH
ENV GO_VERSION 1.16.3
ENV LND_VERSION v0.13.3-beta

# Update & install packages
RUN apt-get update && \
    apt-get install -y wget git make build-essential

# Get go
RUN wget https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz && \
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
