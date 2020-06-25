FROM python:2.7.18-alpine

ENV OFFLINEIMAP_VERSION 7.3.3

RUN apk add --no-cache \
    bash \
    curl \
    make \
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
