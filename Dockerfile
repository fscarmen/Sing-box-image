FROM debian

ARG VERSION TARGETOS TARGETARCH

RUN apt-get -y update &&\
    apt-get install -y wget iproute2 &&\
    wget -P /tmp https://github.com/SagerNet/sing-box/releases/download/v$VERSION/sing-box-$VERSION-linux-$TARGETARCH.tar.gz &&\
    tar xzf /tmp/sing-box-$VERSION-linux-$TARGETARCH.tar.gz -C /tmp sing-box-$VERSION-linux-$TARGETARCH/sing-box &&\
    mv /tmp/sing-box-$VERSION-linux-$TARGETARCH/sing-box /usr/local/bin/sing-box &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /var/log/* /tmp/sing-box*

ENTRYPOINT ["/usr/local/bin/sing-box"]