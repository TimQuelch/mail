FROM alpine as build

ENV NOTMUCH_VERSION 0.29.3
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
    shadow \
    sqlite \
    openssh \
    python3 \
    py3-pip \
    talloc \
    xapian-core \
    zlib \
    && pip3 install afew

RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && usermod --shell /bin/sh mail --password $(openssl rand -base64 12)

COPY --from=build /usr/local /usr/local
RUN ln -s /usr/local/bin/notmuch /usr/bin/ \
    && ln -s /usr/local/bin/muchsync /usr/bin

EXPOSE 22

COPY entrypoint.sh /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
