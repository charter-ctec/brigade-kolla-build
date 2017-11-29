FROM docker:17.06.0-ce-git

ARG KOLLA_VERSION
ENV KOLLA_VERSION ${KOLLA_VERSION:-3.0.2}

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

CMD ["/bin/sh"]