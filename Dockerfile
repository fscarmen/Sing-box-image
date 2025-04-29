# 构建阶段
FROM alpine:latest AS builder

ARG VERSION TARGETOS TARGETARCH

RUN apk add --no-cache wget tar && \
    wget -P /tmp "https://github.com/SagerNet/sing-box/releases/download/v${VERSION}/sing-box-${VERSION}-linux-${TARGETARCH}.tar.gz" && \
    tar xzf "/tmp/sing-box-${VERSION}-linux-${TARGETARCH}.tar.gz" -C /tmp && \
    mv "/tmp/sing-box-${VERSION}-linux-${TARGETARCH}/sing-box" /tmp/sing-box

# 运行阶段
FROM alpine:latest

COPY --from=builder /tmp/sing-box /usr/local/bin/sing-box

ENTRYPOINT ["sing-box"]