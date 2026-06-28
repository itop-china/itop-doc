---
title: "升级 iTop"
linkTitle: "升级 iTop"
date: 2025-06-27
weight: 90
description: "升级 iTop 的完整指南，包括升级前的检查清单和手动/自动升级步骤。"
---

{{% pageinfo %}}
本文档介绍如何升级 iTop，包括升级前的检查清单和手动/自动升级步骤。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:upgrading_itop)。
{{% /pageinfo %}}

## 升级前检查...

### 软件要求

仔细阅读要求，自您上次安装/升级 iTop 实例以来，它们可能已经发生了变化：

- [硬件和软件要求](https://www.itophub.io/wiki/page?id=3_2_0:install:requirements)
- [配置 PHP、Web 服务器和数据库...](https://www.itophub.io/wiki/page?id=3_2_0:install:php_and_mysql_configuration)

### 发行说明

为什么要升级？新版本带来了哪些功能：

| iTop 版本 | 2.7 | 3.0 | 3.1 | 3.2 |
|------|------|------|------|------|
| 新功能 | [2.7 新功能](../../release/start/) | [3.0 新功能](../../release/start/) | [3.1 新功能](../../release/start/) | [3.2 新功能](../../release/whats_new/) |
| 变更日志 | [累积变更日志](../../release/change_log/)（包含每个子版本的详尽变更列表） |

### 迁移说明

在将 iTop 实例升级到新版本之前，请阅读升级路径上的所有迁移说明！例如，如果您从 2.7.x 升级到 3.2.0，您必须阅读以下迁移说明：[2.7 到 3.0](../migration_notes/) 和 [3.0 到 3.1](../migration_notes/) 和 [3.1 到 3.2](../migration_notes/)。

| 目标版本 | 2.7 | 3.0 | 3.1 | 3.2 |
|------|------|------|------|------|
| 迁移说明 | [2.6 到 2.7](../migration_notes/) | [2.7 到 3.0](../migration_notes/) | [3.0 到 3.1](../migration_notes/) | [3.1 到 3.2](../migration_notes/) |

### 扩展兼容性

在升级之前，检查您所有已安装的扩展是否与新版本兼容！

已安装扩展及其版本的列表可以在"关于 iTop..."对话框中找到，位于[注销菜单](../../enduser/01-connecting_to_itop/)中。

通过打开每个扩展的文档来检查兼容性。

## 流程：在测试环境中进行试运行

您应该首先在与相同环境（PHP 和 MySQL 版本和配置）和相同数据的测试环境中尝试更新！

## iTop 升级

### 自动升级

如果您安装的 iTop 实例至少为 2.7.0 版本，您将能够使用应用程序升级器来自动化该过程！它位于**系统 / 应用程序升级**菜单中。这特别推荐用于安全升级，因为通常很少进行更改！

iTop 应用程序升级器将检查系统配置，并在要求未满足时警告您。

如果您因任何原因无法使用 iTop 应用程序更新器（上传大小、写入权限等），请使用以下手动流程。

### 手动升级

- 备份您当前的 iTop 目录（您应该排除 /data/backups）
- 将下载的包解压到您的 iTop 目录中：这将创建一个 /web 子目录
- 如果您使用了 `/webservices/cron.params` 文件，请将其复制到 `/web/webservices`
- 删除旧版本的核心文件：

```bash
rm -rf addons datamodels images lib manifest.xml portal application core dictionaries env-test index.php navigator setup webservices approot.inc.php css js pages synchro documentation bootstrap.inc.php web.config node_modules sources resources templates data/cache-production/*
```

- 您的 iTop 目录现在应包含以下子目录：`conf`、`data`、`env-production`、`log`、`extensions`、`web`（以及如果您安装了它们，可能还有 toolkit 或 collectors）
- iTop 目录级别**没有文件**。您可能需要删除 `bootstrap.inc.php` 和 `templates/`（如果存在，自 2.7.0 起）
- 通过运行以下命令复制新版本的核心文件，仍在您的 iTop 目录中：`cp -r ./web/* .`
- 检查权限（您的 Web 服务器用户必须具有访问权限）
- 更改 iTop 配置文件使其可写：`chmod 644 conf/production/config-itop.php`
- 启动安装程序（在浏览器中使用：`<your_itop_url>/setup`）
- 在第二步，保持"升级"单选按钮选中。检查是否选择了数据库备份
- 在所有后续步骤中点击下一步
- 您的 iTop 目录现在应包含以下子目录：`conf`、`data`、`env-production`、`log`、`extensions`、`web`（以及如果您安装了它们，可能还有 toolkit 或 collectors）
- iTop 目录级别**没有文件**
- 您可能需要删除 `bootstrap.inc.php` 和 `templates/`（如果存在，自 2.7.0 起）

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:upgrading_itop>

版本：3_2_0/install/upgrading_itop.txt · Last modified: 2025/02/12 15:00 by 127.0.0.1
