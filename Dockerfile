FROM alpine:3.7

LABEL maintainer "Zappistore Devops <devops@zappistore.com>"

ARG BUILD_DEPS="ca-certificates wget"
ARG KUBECTL_VERSION="v1.6.6"
ARG KUBECTL_PACKAGE="kubernetes-client-linux-amd64.tar.gz"
ARG KUBECTL_SHA="94b2c9cd29981a8e150c187193bab0d8c0b6e906260f837367feff99860a6376"

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_DEPS && \
    wget --progress=dot:mega https://dl.k8s.io/${KUBECTL_VERSION}/${KUBECTL_PACKAGE} && \
    echo "${KUBECTL_SHA} *${KUBECTL_PACKAGE}" | sha256sum -c - && \
    tar --no-same-owner -xzf ${KUBECTL_PACKAGE} && \
    mv /kubernetes/client/bin/kubectl /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    apk del $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/* /kubernetes*

ENTRYPOINT ["kubectl"]
