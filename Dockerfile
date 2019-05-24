FROM alpine:latest 

ARG RUBY_VERSION
ARG NODE_VERSION
ARG WORKDIR

RUN apk update && \
    apk upgrade && \
    apk --no-cache add git bash gcc g++ make linux-headers zlib-dev openssl-dev readline-dev mariadb-dev python libstdc++ sqlite-dev && \
    git clone https://github.com/rbenv/ruby-build.git ~/.ruby-build && \
    RUBY_CONFIGURE_OPTS=--disable-install-doc ~/.ruby-build/bin/ruby-build $RUBY_VERSION /usr/local/ruby && \
    /usr/local/ruby/bin/gem update --system && \
    ln -s /usr/local/ruby/bin/ruby /usr/bin/ruby && \
    ln -s /usr/local/ruby/bin/bundle /usr/bin/bundle && \
    apk --no-cache add ca-certificates wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-bin-2.29-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-i18n-2.29-r0.apk && \
    apk add glibc-2.29-r0.apk glibc-bin-2.29-r0.apk glibc-i18n-2.29-r0.apk && \
    git clone https://github.com/nodenv/node-build.git ~/.node-build && \
    ~/.node-build/bin/node-build $NODE_VERSION /usr/local/node && \
    ln -s /usr/local/node/bin/node /usr/bin/node && \
    ln -s /usr/local/node/bin/npm /usr/bin/npm

RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR

EXPOSE 3000
