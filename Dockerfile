FROM alpine:3.7

LABEL maintainer "Zappistore Devops <devops@zappistore.com>"

ARG BUILD_DEPS="ca-certificates wget"
ARG KUBECTL_VERSION="v1.7.12"
ARG KUBECTL_PACKAGE="kubernetes-client-linux-amd64.tar.gz"
ARG KUBECTL_SHA="01e87c03e4c928a105ac64618a8923d9d5afa321f9ce2c4d739dad5aa564da72"

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
