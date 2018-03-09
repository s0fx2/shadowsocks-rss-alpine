FROM alpine:latest

MAINTAINER s0fx2

ENV SSR_SERVER_PORT 8667
ENV SSR_PASSWORD 2BRgGQj7gEK4mKhnCt4unKpP
ENV SSR_METHOD none
ENV SSR_PROTOCOL auth_chain_d
ENV SSR_OBFS tls1.2_ticket_auth
ENV FAST_OPEN true

RUN apk update && \
  apk --no-cache upgrade && \
  apk --no-cache add libsodium git python && \
  cd ~ && \
  git clone -b akkariiin/dev https://github.com/shadowsocksrr/shadowsocksr.git

RUN sed -i  's/\("server_port": "\).*/\1'"$SSR_SERVER_PORT"'",/g' /root/shadowsocksr/config.json
RUN sed -i  's/\("password": "\).*/\1'"$SSR_PASSWORD"'",/g' /root/shadowsocksr/config.json
RUN sed -i  's/\("method": "\).*/\1'"$SSR_METHOD"'",/g' /root/shadowsocksr/config.json
RUN sed -i  's/\("protocol": "\).*/\1'"$SSR_PROTOCOL"'",/g' /root/shadowsocksr/config.json
RUN sed -i  's/\("obfs": "\).*/\1'"$SSR_OBFS"'",/g' /root/shadowsocksr/config.json
RUN sed -i  's/\("fast_open": \).*/\1'"$FAST_OPEN"',/g' /root/shadowsocksr/config.json

EXPOSE $SSR_SERVER_PORT

CMD python /root/shadowsocksr/shadowsocks/server.py -c /root/shadowsocksr/config.json
