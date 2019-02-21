FROM alpine:3.8

LABEL maintainer "Zappi Devops <devops@zappistore.com>"

ARG BUILD_DEPS="ca-certificates wget"
ARG KUBECTL_VERSION="v1.11.7"
ARG KUBECTL_PACKAGE="kubernetes-client-linux-amd64.tar.gz"
ARG KUBECTL_SHA="da620f9ade85a0da2e9b4fb36cce08f871be2a0d36034f691ad48161e9c187643778b312e9ecdea348bc7f84c52e541db89d07a5e8f90debff6a618ab08bdd8b"

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_DEPS && \
    wget --progress=dot:mega https://dl.k8s.io/${KUBECTL_VERSION}/${KUBECTL_PACKAGE} && \
    echo "${KUBECTL_SHA} *${KUBECTL_PACKAGE}" | sha512sum -c - && \
    tar --no-same-owner -xzf ${KUBECTL_PACKAGE} && \
    mv /kubernetes/client/bin/kubectl /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    apk del $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/* /kubernetes*

ENTRYPOINT ["kubectl"]
