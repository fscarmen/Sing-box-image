FROM debian

ARG VERSION

RUN apt-get -y update &&\
    apt-get install -y wget iproute2 &&\
    ARCH=$(uname -m | sed "s#x86_64#amd64#; s#aarch64#arm64#") &&\
    wget -P /tmp https://github.com/SagerNet/sing-box/releases/download/v$VERSION/sing-box-$VERSION-linux-$ARCH.tar.gz &&\
    tar xzf /tmp/sing-box-$VERSION-linux-$ARCH.tar.gz -C /tmp sing-box-$VERSION-linux-$ARCH/sing-box &&\
    mv /tmp/sing-box-$VERSION-linux-$ARCH/sing-box /usr/local/bin/sing-box &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /var/log/* /tmp/sing-box*

ENTRYPOINT ["/usr/local/bin/sing-box"]