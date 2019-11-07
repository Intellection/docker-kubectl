FROM alpine:3.10

LABEL maintainer "Zappi Devops <devops@zappistore.com>"

ARG BUILD_DEPS="ca-certificates wget"
ARG KUBECTL_VERSION="v1.15.5"
ARG KUBECTL_PACKAGE="kubernetes-client-linux-amd64.tar.gz"
ARG KUBECTL_SHA="e462587773345695e3d2e2faba53d0bf4a57ab6fe5ae69e5f253fe8529247d05d36d2b8ea6cf5f60dd9c805e29f8385cd42b25d79576248544f26511dc98626b"

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
