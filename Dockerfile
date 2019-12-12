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
ENV GO_VERSION 1.13.5
ENV LND_VERSION v0.8.2-beta-rc1

# Update & install packages for go-callisto dep
RUN apt-get update && \
    apt-get install -y wget git make build-essential

# Get go
RUN wget https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -xvf go${GO_VERSION}.linux-amd64.tar.gz && \
    mv go /usr/local

WORKDIR /opt/lnd

# Get lnd from github
RUN go get -d github.com/lightningnetwork/lnd && \
    cd $GOPATH/src/github.com/lightningnetwork/lnd && \
    make && make install

CMD lnd $OPTIONS
