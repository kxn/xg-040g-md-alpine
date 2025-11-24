# 用于诺基亚贝尔光猫 XG-040G-MD 的 alpine linux 刷机镜像

这个光猫配置不低，带 256M flash + 384 或者 512M 内存，一个 2.5G 网口，三个 1G 网口。咸鱼只要 30 块钱左右，感觉找不到比这个更便宜的 linux 盒子了。所以专门给他做了一个 alpine 的 linux 镜像用来刷机。

分两个版本

* 一个是用的 https://nwrt.kuroneko.host/flashdocs/XG-040G-MD.html 大佬编译的 6.6 的内核，这个应该会更稳定一些。由于 NPU 占用内存，这个版本系统实际可用内存只有 320M 左右
* 一个是我自己编译的基于主线的 6.12 内核 ，主要是去掉了 NPU 占用的内存，反正我 alpine 也不用他做 nat 也没有 wifi ，无需 offload 。这样的话可用内存就有 400 多 M 了。

## 安装

### 打开 telnet

参考 https://godsun.pro/blog/XG-040G-MD 操作，不用拆机。

### 刷机

参考 https://nwrt.kuroneko.host/flashdocs/XG-040G-MD.html ， telnet 进去以后通过 tftp 获取和刷入 tcboot.bin

然后进入 web uboot （这里进入时候很多人掌握不好手感， 上电的那一刻不能按着reset，要上电 1 秒左右以后再按，然后保持按住看灯闪烁到第五次以后不再亮了，才能松开，这时候才进入 web uboot 刷机模式）。刷入本 repo 中的 xg40-alpine.(版本)ubi 即可。默认是 DHCP 获取 IP。 root 密码是 alpine

## 重新打包

运行 ./build.sh ，需要系统安装 ubi 相关工具和 squashfs-tools 

## 已知 bug

* 2.5G 口(lan1) 的 mac 地址没办法完全锁定，通过它 dhcp 到的地址每次会变。1G 口的没问题
* / 下面无法新建文件和目录，其他目录都可以。没有办法做到像 openwrt 那样全盘都能写，这是 alpine openrc 的机制决定的，无法解决。
* 光猫光口是无法使用的，当然这个不是我能搞定的，原始内核就不支持。
* 启动时候如果网络没通，时间没办法对准，就还是 1970 年的，之后插上网线以后不会马上对时，现在是每 5 分钟定时同步一次。
