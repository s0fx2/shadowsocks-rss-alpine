##自己使用的RSS服务器docker版本

###注意：
1.便宜的OpenVZ因为内核基本上达不到docker运行的最低要求，所以就不要尝试了！
Amazon EC2和Google GCP都没问题，不推荐阿里云海外版是因为可能被...你懂的：）

2.密码请到Dockerfile里寻找。

###懒人使用方法：
docker pull s0fx2/shadowsocks-rss-alpine
docker run -d --name rss -it -p 80:80 s0fx2/shadowsocks-rss-alpine

###自己构建：
git clone https://github.com/s0fx2/shadowsocks-rss-alpine.git

修改 SSR_SERVER_PORT 端口号

修改 SSR_PASSWORD 加密密码

修改 SSR_METHOD 加密方法

修改 SSR_PROTOCOL 协议插件

修改 SSR_OBFS 混淆方式


###支持的加密方法：
aes-128-cfb

aes-128-ofb

aes-192-cfb

aes-192-ofb

aes-256-cfb

aes-256-ofb

cast5-cfb

cast5-ofb

chacha20 `推荐`

rc4

rc4-md5

salsa20

###支持的协议插件：
origin：原版协议，为了兼容

verify_sha1：原版OTA协议，为了兼容

auth_sha1_v2：中等安全性，无时间校对的要求，适合路由器或树莓派，混淆强度大

auth_sha1_v4：较高安全性，有宽松的时间校对要求，混淆强度大

auth_aes128_md5或auth_aes128_sha1：最高安全性，有宽松的时间校对要求，计算量相对高一些，混淆强度较大

auth_chain_a（强烈推荐）：对首个包的认证部分进行使用Encrypt-then-MAC模式以真正免疫认证包的CCA攻击，预防各种探测和重防攻击，数据流自带RC4加密，同时此协议支持单端口多用户，不同用户之间无法解密数据，每次加密密钥均不相同，具体设置方法参见breakwa11的博客。使用此插件的服务器与客户机的UTC时间差不能超过24小时，即只需要年份日期正确即可，针对UDP部分也有加密及长度混淆。使用此插件建议加密使用none。此插件不能兼容原协议，支持服务端自定义参数，参数为10进制整数，表示最大客户端同时使用数，最小值支持直接设置为1，此插件能实时响应实际的客户端数量（你的客户端至少有一个连接没有断开才能保证你占用了一个客户端数，否则设置为1时其它客户端一连接别的就一定连不上）。
推荐使用auth_chain_a插件，在以上插件里混淆能力较高，而抗检测能力最高，即使多人使用也难以识别封锁。同时如果要发布公开代理，以上auth插件均可严格限制使用客户端数（要注意的是若为auth_sha1_v4_compatible，那么用户只要使用原协议就没有限制效果），而auth_chain_a协议的限制最为精确。

###支持的混淆方式：
plain：不混淆，无参数

http_simple：简易伪装为http get请求，参数为要伪装的域名，如cloudfront.com。仅在C#版客户端上支持用逗号分隔多个域名如a.com,b.net,c.org，连接时会随机使用其中之一。不填写参数时，会使用此节点配置的服务器地址作为参数。

http_post：与http_simple绝大部分相同，区别是使用POST方式发送数据，符合http规范，欺骗性更好，但只有POST请求这种行为容易被统计分析出异常。参数配置与http_simple一样

tls1.2_ticket_auth：伪装为tls请求。参数配置与http_simple一样

###其他参数请自行添加变量
