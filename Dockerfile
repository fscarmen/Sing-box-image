# 构建阶段
FROM alpine:latest AS builder

# 接收从 GitHub Actions 传来的参数
ARG VERSION TARGETOS TARGETARCH SUFFIX

RUN apk add --no-cache wget tar && \
    # 使用 ${SUFFIX} 来灵活切换是否包含 -musl
    FILENAME="sing-box-${VERSION}-linux-${TARGETARCH}${SUFFIX}" && \
    wget -P /tmp "https://github.com/SagerNet/sing-box/releases/download/v${VERSION}/${FILENAME}.tar.gz" && \
    tar xzf "/tmp/${FILENAME}.tar.gz" -C /tmp && \
    mv "/tmp/${FILENAME}/sing-box" /tmp/sing-box

# 运行阶段
FROM scratch

COPY --from=builder /tmp/sing-box /usr/local/bin/sing-box

ENTRYPOINT ["sing-box"]