FROM alpine:latest
RUN apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

ARG TARGETARCH
WORKDIR /dist
ADD dist/gomain_linux_$TARGETARCH/main .
RUN apk add --no-cache tini
#http 和 grpc
EXPOSE 8080
ENTRYPOINT ["/sbin/tini", "--"]
#command 
CMD ["/bin/sh", "-c", "/dist/main serve"]
