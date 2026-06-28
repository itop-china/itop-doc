---
title: "硬件和软件要求"
linkTitle: "硬件和软件要求"
date: 2025-06-27
weight: 10
description: "iTop 的硬件和软件要求，包括兼容性列表和浏览器支持。"
---

{{% pageinfo %}}
本文档介绍 iTop 的硬件和软件要求，包括兼容性列表和浏览器支持。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:requirements)。
{{% /pageinfo %}}

## 最低硬件要求

| 您的需求 | 我们的建议 |
|------|------|
| 每月创建工单数 | 控制台用户 | CMDB: CI 数量 | 服务器 | CPU | 内存 | MySQL 磁盘 |
| <200 | < 20 | <50k | 一体化服务器 | 2vCPU | 4Gb | 10Gb |
| < 5000 | < 50 | <200k | 两台服务器：Web + MySQL | 4vCPU | 8Gb | 20Gb |
| > 5000 | > 50 | > 200k | 两台服务器：Web + MySQL | 8vCPU | 16Gb | 50Gb |

使用 iTop 的最低屏幕分辨率为 1024*768 像素，但分辨率越高越好。

我们建议使用运行 **Debian 12** 或 **Ubuntu 24.04 LTS** 的虚拟机。

## iTop 兼容性列表

| iTop | 最低要求 → 最高支持 | 已知限制 |
|------|------|------|
| | PHP | MySQL | MariaDB | |
| 2.3.x | 5.3.6 | 5.0 | | |
| 2.4.x | 5.3.6 | 5.5.3 | | |
| 2.5.x | 5.3.6 | 5.5.3 | 5.5 | |
| 2.6.0 / 2.6.1+ | 5.6 → 7.2 / 5.6 → 7.3 | 5.6 | 10.1 | MySQL 8 不工作，PHP 7.4 不工作 / PHP 7.3 从 2.6.1 起支持 |
| 2.7.x / 2.7.7 - 2.7.8 | 7.0.8 → 7.4 / 7.1.3 → 7.4 | 5.6 → 5.7 | 10.1 → 10.4 | MySQL 8 支持（不推荐用于大型数据库！），推荐 PHP 7.4 / IE9 不再支持 / PHP 5.6 和 7.0.8 可以工作，但不能使用所有扩展 / 如果使用 oAuth2 或 Brute Force Protection 扩展，则需要 PHP 7.1.3 最低版本 |
| 2.7.9+ | 7.1.3 → 7.4 | 5.6 → 5.7 | 10.1 → 10.6 | 需要 PHP 7.1.3 最低版本 |
| 3.0.x / 3.0.2 | 7.1.3 → 7.4 / 7.1.3 → 8.0 | 5.7+ | 10.3+ | MariaDB 现在优先于 MySQL / IE11 不再支持 / PHP 8.0 仅从 3.0.2 起支持 / PHP 8.1+ 不支持 |
| 3.1.x | 7.4 → 8.1 | 5.7+ | 10.3.7+ | |
| 3.2.x | 8.1 → 8.3 | 5.7+ | 10.6 → 11.8 | PHP 8.4 不支持（已知问题）/ 没有已知问题与 MariaDB 超出所写限制 |
| 3.2.3-1 | 8.1 → 8.4 | 5.7+ | 10.6 → 11.8 | PHP 8.4 支持 |
| 3.3.x | 8.2 → 8.4 | 5.7+ | 10.6 → 11.8 | |

图例：

- **粗体**：自上一版本以来最低或最高版本发生变化时
- *斜体*：最高支持版本，当已知时

## Web 浏览器

推荐使用最新版本的 **Chrome**（**Firefox** 也很安全）。

- 自 2.7.0 起，不再支持 IE9
- 自 3.0.0 起，不再支持 IE11
- 后续版本的 iTop 将不再支持任何 Internet Explorer 版本
- **Brave** 与 iTop 有已知的兼容性问题
- **Safari** 不受 Combodo 支持，但我们知道有人在使用它，报告的问题很少。

## Web 服务器

### 配置您的 Web 服务器

- **Apache Httpd**：iTop 包包含 Apache Httpd 的内置配置（.htaccess 文件）。在此处阅读更多：[iTop 和 Apache HTTPD](../install_guides/)
- **Microsoft IIS**：iTop 包包含 Microsoft IIS 的内置配置（web.config 文件）。在此处阅读更多：[iTop 和 IIS](../install_guides/)
- **NGINX**：要正确配置 NGINX，请查看此专用页面：[iTop 和 NGINX](https://www.itophub.io/wiki/page?id=3_2_0:install:nginx)
- **Suhosin**：[iTop 和 Suhosin](https://www.itophub.io/wiki/page?id=3_2_0:install:suhosin)
- **SELinux**：[iTop 和 SE Linux](https://www.itophub.io/wiki/page?id=3_2_0:install:selinux)

### GraphViz

iTop 依赖 **Graphviz** 来生成对象生命周期的图形表示以及影响分析图。

- 在 Linux 上，graphviz 已经是上述先决条件的一部分，因此无需额外操作。
- 在 Windows 上：从网站下载 [Graphviz](https://graphviz.org/download/) 并安装。
- Linux：`/user/bin/dot`
- Windows：`C:\Program files (x86)\Graphviz 2.68\bin\dot.exe`

## 数据库服务器

要选择数据库版本，请查看 [MariaDB 各版本发布说明](https://mariadb.com/kb/en/mariadb-release-notes/) 和 [MySQL 文档](https://dev.mysql.com/doc/)

### MariaDB 与 iTop 备份的不兼容性

以下版本的 MariaDB 会导致 iTop 备份无法工作：

| 10.5.x | 10.4.x | 10.3.x | 10.2.x |
|------|------|------|------|
| 10.5.7 | 10.4.16 | 10.3.26 | 10.2.35 |
| 10.5.8 | 10.4.17 | 10.3.27 | 10.2.36 |

症状：

当您执行此查询时：

```sql
MariaDB [sbacmdb]> select * from view_DBServer;
```

您会收到此错误：

```
Error: Failed to execute mysqldump: mysqldump: Couldn't execute 'show create table `view_DBServer`': You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '= 0 and `SoftwareLicence_softwarelicence_id_Licence`.`end_date` < date_format...' at line 1 (1064)
```

根本原因：这是一个 MariaDB 问题，在以下次要版本中已修复。

策略：避免这些有问题的 MariaDB 版本。降级到不受影响的版本或升级到已修复的版本：

| 10.5.9 | 10.4.18 | 10.3.28 | 10.2.37 |
|------|------|------|------|

变通方法：

- 在备份前删除视图，视图不是 iTop 本身所需的。
- 注意，安装程序会重新创建视图，因此之后需要再次删除它们。

视图将在 3.0 中完全移除，对于仍在使用它们的人，将提供一个可选的免费扩展。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:requirements>

版本：3_2_0/install/requirements.txt · Last modified: 2026/06/11 16:17 by 127.0.0.1
