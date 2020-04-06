FROM alpine

ENV OFFLINEIMAP_VERSION 7.3.2

RUN apk add --no-cache \
    bash \
    curl \
    make \
    python2 \
    py-pip \
    tar

RUN curl -L "https://github.com/OfflineIMAP/offlineimap/archive/v${OFFLINEIMAP_VERSION}.tar.gz" | tar xz \
    && cd offlineimap-${OFFLINEIMAP_VERSION} \
    && pip install six rfc6555 \
    && make \
    && python setup.py install \
    && cd / \
    && rm -rf offlineimap-${OFFLINEIMAP_VERSION}

USER mail
CMD ["offlineimap"]
