FROM alpine:3.5

MAINTAINER s0fx2

ENV SSR_SERVER_PORT 443
ENV SSR_PASSWORD CTE4R7jbPgau)bB+hn
ENV SSR_METHOD chacha20
ENV SSR_PROTOCOL auth_aes128_md5
ENV SSR_OBFS tls1.2_ticket_auth



RUN apk update && \
    apk --no-cache upgrade && \

# add chacha20(libsodium) git python etc.
    apk --no-cache add libsodium git python && \

# clone ssr
    cd ~ && \
    git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git

EXPOSE $SSR_SERVER_PORT

CMD python /root/shadowsocksr/shadowsocks/server.py -p $SSR_SERVER_PORT -k $SSR_PASSWORD -m $SSR_METHOD -O $SSR_PROTOCOL -o $SSR_OBFS
