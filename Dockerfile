FROM docker:17.06.0-ce-git

ENV KOLLA_BASE=ubuntu \
    KOLLA_TYPE=source \
    KOLLA_TAG=3.0.1 \
    KOLLA_PROJECT=keystone \
    KOLLA_NAMESPACE=kolla \
    KOLLA_VERSION=3.0.1 \
    DOCKER_USER=docker-user \
    DOCKER_PASS=docker-pass \
    DOCKER_REGISTRY=quay.io \
    DEBIAN_FRONTEND=noninteractive

RUN apk update && apk add --update \
    gcc \
    python \
    python-dev \
    py-pip \
    py-virtualenv \
    build-base \
    openssl-dev \
    libffi-dev

RUN rm -rf /var/lib/apk/lists/* /tmp/* /var/tmp/*

COPY start.sh /usr/local/bin/start.sh
COPY push.sh /usr/local/bin/kolla-push.sh

CMD ["/bin/sh"]