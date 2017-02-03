自己使用的RSS服务器docker版本

懒人使用方法：

docker pull s0fx2/shadowsocks-rss-alpine
docker run -d --name  rss -it -p 80:80 shadowsocks-rss-alpine

自己构建：
git clone https://github.com/s0fx2/shadowsocks-rss-alpine.git
修改 SSR_SERVER_PORT 端口号
修改 SSR_PASSWORD 加密密码
修改 SSR_METHOD 加密方法
修改 SSR_PROTOCOL 协议插件
修改 SSR_OBFS 混淆方式

可用的加密方法：
aes-128-cfb
aes-128-ofb
aes-192-cfb
aes-192-ofb
aes-256-cfb
aes-256-ofb
cast5-cfb
cast5-ofb 
chacha20 推荐
rc4
rc4-md5
salsa20
可用的协议插件：
origin：原版协议，为了兼容
verify_sha1：原版OTA协议，为了兼容
auth_sha1_v2：中等安全性，无时间校对的要求，适合路由器或树莓派，混淆强度大
auth_sha1_v4：较高安全性，有宽松的时间校对要求，混淆强度大
auth_aes128_md5或auth_aes128_sha1：最高安全性，有宽松的时间校对要求，计算量相对高一些，混淆强度较大

可用的混淆方式：
plain：不混淆，无参数
http_simple：简易伪装为http get请求，参数为要伪装的域名，如cloudfront.com。仅在C#版客户端上支持用逗号分隔多个域名如a.com,b.net,c.org，连接时会随机使用其中之一。不填写参数时，会使用此节点配置的服务器地址作为参数。
http_post：与http_simple绝大部分相同，区别是使用POST方式发送数据，符合http规范，欺骗性更好，但只有POST请求这种行为容易被统计分析出异常。参数配置与http_simple一样
tls1.2_ticket_auth：伪装为tls请求。参数配置与http_simple一样