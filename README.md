# 用于诺基亚贝尔光猫 XG-040G-MD 的 alpine linux 刷机镜像

这个光猫配置不低，带 256M flash + 384 或者 512M 内存，一个 2.5G 网口，三个 1G 网口。咸鱼只要 30 块钱左右，感觉找不到比这个更便宜的 linux 盒子了。所以专门给他做了一个 alpine 的 linux 镜像用来刷机。

内核直接用的 https://nwrt.kuroneko.host/flashdocs/XG-040G-MD.html 大佬编译的，自己没有重新编译。

## 安装

### 打开 telnet

参考 https://godsun.pro/blog/XG-040G-MD 操作，不用拆机。

### 刷机

参考 https://nwrt.kuroneko.host/flashdocs/XG-040G-MD.html ， telnet 进去以后通过 tftp 获取和刷入 tcboot.bin

然后进入 web uboot ，刷入本 repo 中的 xg40-alpine.ubi 即可。默认是 DHCP 获取 IP。 root 密码是 alpine

## 重新打包

以 root 身份 tar zxf rootfs.tar.gz
之后运行 ./build.sh ，需要系统安装 ubi 相关工具和 squashfs-tools
