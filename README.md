# clash for IPFire 

# 项目介绍

此项目是通过使用开源项目[mihomo](https://github.com/MetaCubeX/mihomo)作为核心程序，再结合脚本实现简单的代理功能。

主要是为了解决我们在服务器上下载GitHub等一些国外资源速度慢的问题。

<br>

# 使用须知

- 运行本项目建议使用root用户，或者使用 sudo 提权。
- 在进行issues提交前，请替换提交内容中是敏感信息（例如：订阅地址）。
- 本项目是基于[mihomo](https://github.com/MetaCubeX/mihomo)、[yacd](https://github.com/haishanh/yacd) 进行的配置整合，关于mihomo、yacd的详细配置请去原项目查看。
- 此项目不提供任何订阅信息，请自行准备订阅地址。
- 运行前请手动更改`.env`文件中的`CLASH_URL`变量值，否则无法正常运行。
- 在IPFire2.29系统中测试通过，其他系列可能需要适当修改脚本。
- 支持x86_64/aarch64平台。

<br>

# 使用教程

## 下载项目

下载项目，进入到项目目录，编辑`.env`文件，修改变量`CLASH_URL`的值（订阅链接）。

```bash
$ cd clash-for-IPFire
$ vim .env
```

> **注意：** `.env` 文件中的变量 `CLASH_SECRET` 为自定义 Clash Secret，值为空时，脚本将自动生成随机字符串。

<br>

## 启动程序

- 进入项目目录

```bash
$ cd clash-for-IPFire
```

- 运行启动脚本

```bash
$ sudo bash start.sh

正在检测订阅地址...
Clash订阅地址可访问！                                      [  OK  ]

正在下载Clash配置文件...
配置文件config.yaml下载成功！                              [  OK  ]

正在启动Clash服务...
服务启动成功！                                             [  OK  ]

Clash Dashboard 访问地址：http://<ip>:9090/ui
Secret：xxxxxxxxxxxxx

请执行以下命令加载环境变量: source /etc/profile.d/clash.sh

请执行以下命令开启系统代理: proxy_on

若要临时关闭系统代理，请执行: proxy_off

```

```bash
$ source /etc/profile.d/clash.sh
$ proxy_on
```

- 检查服务端口

```bash
$ netstat -tln | grep -E '9090|789.'
tcp        0      0 127.0.0.1:9090          0.0.0.0:*               LISTEN     
tcp6       0      0 :::7890                 :::*                    LISTEN     
tcp6       0      0 :::7891                 :::*                    LISTEN     
tcp6       0      0 :::7892                 :::*                    LISTEN
```

- 检查环境变量

```bash
$ env | grep -E 'http_proxy|https_proxy'
http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
```

以上步鄹如果正常，说明服务clash程序启动成功，现在就可以体验高速下载github资源了。

<br>

## 重启程序

如果需要对Clash配置进行修改，请修改 `conf/config.yaml` 文件。然后运行 `restart.sh` 脚本进行重启。

> **注意：**
> 重启脚本 `restart.sh` 不会更新订阅信息。

<br>

## 停止程序

- 进入项目目录

```bash
$ cd clash-for-IPFire
```

- 关闭服务

```bash
$ sudo bash shutdown.sh

服务关闭成功，请执行以下命令关闭系统代理：proxy_off

```

```bash
$ proxy_off
```

然后检查程序端口、进程以及环境变量`http_proxy|https_proxy`，若都没则说明服务正常关闭。

<br>

## 开机自启

脚本会自动在/etc/sysconfig/rc.local添加开机启动脚本，实现开机自动启动代理。

<br>

## Clash仪表盘

- 访问Clash仪表盘

通过浏览器访问 `start.sh` 执行成功后输出的地址，例如：http://192.168.0.1:9090/ui

- 登录管理界面

在`API Base URL`一栏中输入：http://\<ip\>:9090 ，在`Secret(optional)`一栏中输入启动成功后输出的Secret。

点击Add并选择刚刚输入的管理界面地址，之后便可在浏览器上进行一些配置。

