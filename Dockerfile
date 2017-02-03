FROM alpine:3.5

MAINTAINER s0fx2 <9288171@qq.com>

ENV SSR_SERVER_PORT 80
ENV SSR_PASSWORD [s]HF8jt7qbC?L,Rc2
ENV SSR_METHOD chacha20
ENV SSR_PROTOCOL auth_aes128_md5
ENV SSR_OBFS http_simple



RUN apk update && \
    apk upgrade && \

# add chacha20(libsodium) git python etc.
    apk add libsodium git python && \

# clone ssr
    cd ~ && \
    git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git

EXPOSE $SSR_SERVER_PORT

CMD python /root/shadowsocksr/shadowsocks/server.py -p $SSR_SERVER_PORT -k $SSR_PASSWORD -m $SSR_METHOD -O $SSR_PROTOCOL -o $SSR_OBFS
