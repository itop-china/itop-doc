---
title: "安装 iTop"
linkTitle: "安装 iTop"
date: 2025-06-27
weight: 70
description: "在 Ubuntu 上使用 Apache 和 MariaDB 快速安装 iTop 的指南。"
---

{{% pageinfo %}}
本文档介绍如何在 Ubuntu 上快速安装 iTop。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:installing_itop)。
{{% /pageinfo %}}

## 在 Ubuntu 上快速安装

（其他环境的命令请参阅[安装指南](https://www.itophub.io/wiki/page?id=3_2_0:install:install_guides)）

### 安装 iTop

运行以下命令在 Ubuntu 上使用 Apache 和 MariaDB 安装 iTop：

```bash
sudo apt-get update
apt-get install mariadb-server libapache2-mod-php php php-mysql php-cli php-json graphviz php-xml php-gd php-zip php-curl php-soap php-mbstring php-apcu php-ldap php-imap

wget https://sourceforge.net/projects/itop/files/latest/download -O /tmp/itop.zip
sudo unzip /tmp/itop.zip "web/*" -d /var/www/html/itop
sudo mv /var/www/html/itop/web/* /var/www/html/itop
sudo rmdir /var/www/html/itop/web
sudo setfacl -dR -m u:"www-data":rwX /var/www/html/itop/data /var/www/html/itop/log
sudo setfacl -R -m u:"www-data":rwX /var/www/html/itop/data /var/www/html/itop/log
sudo setfacl -m u:"www-data":rwX /var/www/html/itop/
sudo mkdir /var/www/html/itop/env-production /var/www/html/itop/env-production-build /var/www/html/itop/env-test /var/www/html/itop/env-test-build
sudo chown www-data: /var/www/html/itop/conf /var/www/html/itop/env-production /var/www/html/itop/env-production-build /var/www/html/itop/env-test /var/www/html/itop/env-test-build
```

### 启动安装

从 Web 浏览器启动安装，访问此 URL：`https://myserver.mydomain.com/itop/setup`，然后按照[安装向导](https://www.itophub.io/wiki/page?id=3_2_0:install:install_wizard)操作。

### 安装完成后

- 确保应用程序可访问并了解用户界面：[您首次连接 iTop](../../enduser/01-connecting_to_itop/)。
- 创建 iTop 应用程序可供用户使用的最小对象集：请遵循[实施指南](../../implementation/)。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:installing_itop>

版本：3_2_0/install/installing_itop.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
