---
title: "安装 PHP、Web 服务器和数据库..."
linkTitle: "安装 PHP、Web 服务器和数据库..."
date: 2025-06-27
weight: 20
description: "在 Debian/Ubuntu、RedHat/CentOS/Fedora 和 Windows 上安装 iTop 所需的 PHP、Web 服务器和数据库软件。"
---

{{% pageinfo %}}
本文档介绍如何在不同操作系统上安装 iTop 所需的 PHP、Web 服务器和数据库软件。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:install_guides)。
{{% /pageinfo %}}

## Debian 或 Ubuntu

要在 Ubuntu/Debian 上安装所需软件，请运行以下命令（以 root 身份）：

```bash
apt-get install apache2
apt-get install mariadb-server
apt-get install php php-mysql php-ldap php-cli php-soap php-json graphviz
apt-get install php-xml php-gd php-zip libapache2-mod-php php-mbstring php-curl
```

```bash
apt-get install apache2
apt-get install mysql-server
apt-get install php php-mysql php-ldap php-cli php-soap php-json graphviz
apt-get install php-xml php-gd php-zip libapache2-mod-php php-mbstring php-curl
```

这将安装 Ubuntu/Debian 默认仓库中对应的版本。

## RedHat、CentOS 或 Fedora

要在 RedHat / CentOS / Fedora 上安装所需软件，请运行以下命令（以 root 身份）：

```bash
yum install httpd
yum install mysql mysql-server
yum install php php-mysql php-xml php-cli php-soap php-ldap php-gd php-zip php-json php-mbstring php-curl graphviz
```

## Windows

### 在 IIS 上安装 PHP

请查看此页面：iTop 和 IIS

### 安装 MySQL

如果您还没有 MySQL 数据库服务器，可以将其安装在与应用程序相同的系统上。

- 访问 MySQL 下载站点：http://www.mysql.com/downloads/mysql/
- 下载适合您系统的安装程序：选择名为 "MSI Installer" 的安装包，32 位或 64 位版本均可。
- 通过打开下载的 .msi 文件启动安装。
- 按照安装向导的说明进行操作。

## Windows 上使用 easyPHP 的开发环境

请参见 iTop 在 Windows 上使用 easyPHP 安装

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:install_guides>

版本：3_2_0/install/install_guides.txt · Last modified: 2025/07/11 16:22 by 127.0.0.1
