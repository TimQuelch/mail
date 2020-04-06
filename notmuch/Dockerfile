FROM alpine as build

ENV NOTMUCH_VERSION 0.29
ENV MUCHSYNC_VERSION 5

RUN apk add --no-cache \
    bash \
    curl \
    gcc \
    g++ \
    gmime-dev \
    libc-dev \
    make \
    openssl-dev \
    perl \
    sqlite-dev \
    talloc-dev \
    tar \
    xapian-core-dev \
    zlib-dev

RUN curl -L "https://notmuchmail.org/releases/notmuch-${NOTMUCH_VERSION}.tar.xz" | tar xJ \
    && cd notmuch-${NOTMUCH_VERSION} \
    && make \
    && make install

RUN curl -L "http://www.muchsync.org/src/muchsync-${MUCHSYNC_VERSION}.tar.gz" | tar xz \
    && cd muchsync-${MUCHSYNC_VERSION} \
    && ./configure \
    && make \
    && make install

FROM alpine

RUN apk add --no-cache \
    ca-certificates \
    curl \
    gmime \
    openssl \
    sqlite \
    talloc \
    xapian-core \
    zlib

COPY --from=build /usr/local /usr/local

USER mail
