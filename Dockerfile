FROM alpine:3.5

MAINTAINER Zappi DevOps <devops@zappistore.com>

ARG APP_DEPS="ca-certificates"
ARG BUILD_DEPS="wget"
ARG KUBECTL_VERSION="v1.4.7"
ARG KUBECTL_PACKAGE="kubernetes-client-linux-amd64.tar.gz"
ARG KUBECTL_RBENV_SHA="36232c9e21298f5f53dbf4851520a8cc53a2d6b6d2be8810cf5258a067570314"

RUN apk update && \
    apk upgrade && \
    apk add $APP_DEPS && \
    apk add $BUILD_DEPS && \
    wget --progress=dot:mega https://dl.k8s.io/${KUBECTL_VERSION}/${KUBECTL_PACKAGE} && \
    echo "${KUBECTL_RBENV_SHA} *${KUBECTL_PACKAGE}" | sha256sum -c - && \
    tar --no-same-owner -xzf ${KUBECTL_PACKAGE} && \
    mv /kubernetes/client/bin/kubectl /usr/local/bin/kubectl && \
    rm -R /kubernetes* && \
    apk del $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/* /kubernetes*

ENTRYPOINT ["kubectl"]
