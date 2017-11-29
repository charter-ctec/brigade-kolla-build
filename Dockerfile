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
#COPY clean.sh /usr/local/bin/clean.sh
COPY push.sh /usr/local/bin/kolla-push.sh

# RUN chmod +x /usr/local/bin/start.sh && \
#     chmod +x /usr/local/bin/clean.sh && \
#     chmod +x /usr/local/bin/kolla-push.sh

WORKDIR /root

RUN git clone http://git.openstack.org/openstack/kolla.git ./kolla-$KOLLA_VERSION && \
    cd ./kolla-$KOLLA_VERSION && \
    git checkout tags/$KOLLA_VERSION

RUN mkdir -p .venv && \
    virtualenv .venv/kolla-builds && \
    . .venv/kolla-builds/bin/activate && \
    cd ./kolla-$KOLLA_VERSION && \
    pip install -e . && \
    mkdir -p /etc/kolla

RUN mkdir -p /root/.kolla-$KOLLA_VERSION/src/$KOLLA_PROJECT && \
    git clone http://git.openstack.org/openstack/$KOLLA_PROJECT.git /tmp/kolla/src/$KOLLA_PROJECT

COPY kolla-build.conf /etc/kolla/kolla-build.conf

WORKDIR /root/.kolla-$KOLLA_VERSION

ENTRYPOINT ["/usr/local/bin/start.sh"]
CMD ["/bin/sh"]