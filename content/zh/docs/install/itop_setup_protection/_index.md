---
title: "保护 iTop 安装"
linkTitle: "保护 iTop 安装"
date: 2025-06-27
weight: 60
description: "如何禁用 iTop 安装向导以减少攻击面。"
---

{{% pageinfo %}}
本文档介绍如何在首次安装后禁用 iTop 安装向导，以减少攻击面。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:itop_setup_protection)。
{{% /pageinfo %}}

## 为什么

首次安装时使用的安装向导应该被禁用，以减少攻击面。有两个文件特别需要注意：

- `setup/index.php`：当然需要保护
- `setup/phpinfo.php`：会泄露大量系统信息（注意：自 iTop 2.5.2、2.6.1 和 2.7.0 起，通过添加认证已降低了风险）

## 如何保护

您不应该删除整个 `setup/` 目录，因为它包含 iTop 所需的文件。

相反，您可以使用适合您所用 Web 服务器的文件来阻止 Web 访问。`data/` 目录中已经有这样的文件，例如：

- **Apache httpd**：https://github.com/Combodo/iTop/blob/develop/data/.htaccess
- **Microsoft IIS**：https://github.com/Combodo/iTop/blob/develop/data/web.config

## iTop 更新

为了方便 iTop 更新，您可能希望自动化该过程。请参阅[自动化安装](https://www.itophub.io/wiki/page?id=3_2_0:install:install_wizard)。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:itop_setup_protection>

版本：3_2_0/install/itop_setup_protection.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
