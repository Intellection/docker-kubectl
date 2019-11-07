FROM alpine:3.10

LABEL maintainer "Zappi Devops <devops@zappistore.com>"

ARG BUILD_DEPS="ca-certificates wget"
ARG KUBECTL_VERSION="v1.13.12"
ARG KUBECTL_PACKAGE="kubernetes-client-linux-amd64.tar.gz"
ARG KUBECTL_SHA="43830293485863452aa2b5d87456ac575fbfa2f2115e04091596dd51ca8192cccdd18704e31ab5f20da4bfd1567340b08643e9060c47194d3ac224b965333af9"

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
CMD [ "--help" ]
