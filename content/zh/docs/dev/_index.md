---
title: "开发调试指南"
linkTitle: "开发调试指南"
date: 2022-11-26
weight: 100
description: >
  本文档解释了如何快速搭建开发调试环境

---

这里我们使用docker进行环境部署和开发调试。

1、下载代码到本地，解压web目录，在目录中执行以下命令

```
docker run -d -p 8000:80 -p 3306:3306 -v $PWD:/var/www/html/ --name=itop-3.0.0 vbkunin/itop:3.0.0
```

2、输入`http://localhost:8000/`，进行安装。

3、安装中需要输入数据库地址和密码，执行下方命令：
```
docker logs itop-3.0.0 | grep -A7 -B1 "Your MySQL user 'admin' has password:"
```

4、安装toolkit
```
docker exec itop-3.0.0 /install-toolkit.sh
```
国内无法访问对应包，可以下载后，拷贝到开发程序目录中。

地址来源：
- https://www.combodo.com/documentation/iTopDataModelToolkit-3.0.0.zip
- https://github.com/Combodo/itop-toolkit-community/archive/refs/tags/3.0.0.zip

5、开启远程调试

首先，调整源：
```
# 进入容器
docker exec -it itop-3.0.0 /bin/bash
# 执行以下命令
echo '
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse 

deb https://ppa.launchpadcontent.net/ondrej/php/ubuntu focal main 
#deb-src https://ppa.launchpadcontent.net/ondrej/php/ubuntu focal main 
' > /etc/apt/sources.list.d/aliyun.list
# 退出
exit
```
其次，执行调试命令：docker exec itop-3.0.0 /install-xdebug.sh [client_port] [idekey]，如下
```
docker exec itop-3.0.0 /install-xdebug.sh 9003 phpstorm
```
6、配置PHPSTORM

-  Languages & Frameworks  >> PHP >>Debug 设置9003端口
-  新建调试Run/Debug Configurations
  - 新建PHP Remote Debug -> 新建Server -> Host地址 ->mapping path ->IDE KEY(PHPSTORM) 
  - Validate验证配置



参考资料：
- 1、https://github.com/vbkunin/itop-docker
- 2、http://wjhsh.net/yjken-p-6555438.html
- 3、https://github.com/Combodo/itop-toolkit-community/releases