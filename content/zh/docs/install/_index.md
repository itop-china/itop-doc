
---
title: "安装/升级 iTop"
linkTitle: "安装/升级 iTop"
date: 2025-06-27
weight: 12
description: >
  介绍 iTop 3.2.0 的安装、升级、迁移说明和系统要求。
---

{{% pageinfo %}}
本章节介绍如何安装和升级 iTop 3.2.0 LTS。对于从旧版本迁移的用户，请先阅读迁移说明。
{{% /pageinfo %}}

## 系统要求

iTop 3.2.0 需要以下环境：

- Web 服务器：Apache 2.4+ 或 IIS 10+
- PHP：8.0 或更高版本（推荐 8.1/8.2）
- 数据库：MySQL 5.7+ 或 MariaDB 10.2+
- 浏览器：现代浏览器（Chrome、Firefox、Edge、Safari）

## 安装 iTop

### 下载

从 [SourceForge](https://sourceforge.net/projects/itop/files/itop/3.2.0/) 或 [iTop Hub](https://www.itophub.io/) 下载最新安装包。

### 安装向导

1. 解压安装包到 Web 服务器目录
2. 创建 MySQL/MariaDB 数据库和用户
3. 访问 `http://your-server/itop` 启动安装向导
4. 按向导提示完成数据库连接、管理员账号、示例数据等配置

详细的安装步骤请参考 [iTop 官方安装文档](https://www.itophub.io/wiki/page?id=3_2_0:install:start)。

## 升级 iTop

### 升级前准备

- 备份数据库和 `conf/production/config-itop.php` 配置文件
- 查看 [3.2.0 迁移说明](https://www.itophub.io/wiki/page?id=3_2_0:install:migration_notes)
- 检查现有扩展是否兼容 3.2.0

### 升级步骤

1. 下载 3.2.0 安装包
2. 覆盖现有文件（保留 `conf/`、`data/`、`log/` 目录）
3. 运行 `/setup` 进入升级向导
4. 按提示完成数据库结构升级

## 子章节

- [硬件和软件要求](./requirements/)
- [安装 PHP、Web 服务器和数据库](./install_guides/)
- [配置 PHP、Web 服务器和数据库](./php_and_mysql_configuration/)
- [使用 TLS 连接 MySQL](./php_and_mysql_tls/)
- [iTop 和反向代理](./reverse_proxy/)
- [保护 iTop 安装](./itop_setup_protection/)
- [安装 iTop](./installing_itop/)
- [安装向导](./install_wizard/)
- [升级 iTop](./upgrading_itop/)
- [更新向导](./update_wizard/)
- [3.1.x 到 3.2.0 迁移说明](./migration_notes/)
- [将 iTop 移动到不同的 URL](./moving_itop/)
- [iTop 与 NGINX](./nginx/)
- [iTop 与 SELinux](./selinux/)
- [iTop 与 Suhosin](./suhosin/)

## 开始使用

安装完成后，可以参考 [实施指南](../implementation/) 配置组织、用户、服务目录等基础数据，使 iTop 投入实际使用。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:start>

版本：3_2_0/install/start.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
