---
title: "升级向导"
linkTitle: "升级向导"
date: 2025-06-27
weight: 100
description: "使用 iTop 更新向导逐步升级应用程序的详细说明。"
---

{{% pageinfo %}}
本文档介绍 iTop 更新向导的详细步骤。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:install:update_wizard)。
{{% /pageinfo %}}

## 更新向导

- 确保 iTop 配置文件（`conf/production` 中的 `config-itop.php`）不是只读的。
- 将 Web 浏览器指向 `http(s)://location_of_itop/setup` 并按照屏幕上的说明操作。

用于[安装应用程序](https://www.itophub.io/wiki/page?id=3_2_0:install:install_wizard)的分步向导在升级时会被复用，但有一些差异。

### 第一步：检查配置和先决条件

第一步检查配置的一致性以及 MySQL、PHP 和可选 PHP 扩展的先决条件。在升级过程中可能会失败，因为它可能比以前的版本更严格。例如，在 2.5.0 之后，MySQL 和 PHP 的先决条件将会改变。

### 第二步：数据库连接和备份

更新的第二步总结了之前在安装中提供的数据库连接信息，并默认建议在应用程序和数据库升级之前创建 iTop 备份。

### 第三步：其他信息

升级的第三步提示您输入几个其他信息，这些信息在升级期间仍然可以更改。

### 配置 CMDB

您不能删除在**初始安装**时安装的模块，但可以添加一些。

### 配置服务管理

在大多数情况下，这是在**初始安装**时设置的，不能更改。

### 配置工单管理

如果您**现在**想在 iTop 中管理工单，请查看[安装](https://www.itophub.io/wiki/page?id=3_2_0:install:install_wizard)中的可选选项。一旦在之前的安装中做出了选择，您就不能在**简单**和 **ITIL 合规**工单管理之间切换，也不能停用工单管理模块。

### 配置变更管理

如果您**现在**想在 iTop 中管理变更，请查看[安装](https://www.itophub.io/wiki/page?id=3_2_0:install:install_wizard)中的可选选项。一旦在之前的安装中做出了选择，您就不能在**简单**和 **ITIL 合规**变更管理之间切换，也不能停用变更管理。

### 其他 ITIL 流程

您不能删除在**初始安装**时安装的模块，但可以添加一些。

### 其他模块/扩展

如果您已添加模块/扩展，它们可以在升级过程的此步骤中安装，但**不能删除**。

### 启动升级

完成所有选择后，将显示摘要。您可以点击每个部分的"加号"按钮来查看您的选择。

要开始实际的 iTop 升级，请点击"安装！"按钮。

升级进度将显示一个移动的进度条。

升级完成后，您会看到：

恭喜，您已成功升级 iTop！

## 内部机制

在安装开始时，iTop 通过 `<itop>/data` 下的名为 `.readonly` 的文件进入**只读**模式。应用程序不再可写，因为数据库结构可能会被大幅修改。然后在数据模型编译期间，iTop 通过在同一位置放置名为 `.maintenance` 的文件进入**维护**模式。因为在此阶段不再有有效的 iTop 代码可以使用，即使是只读模式。

此机制适用于：

- 安装
- 当 iTop Hub 推送扩展时
- 当 ITSM Designer 推送新数据模型时（针对 Combodo 客户）
- 应用程序升级时

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:install:update_wizard>

版本：3_2_0/install/update_wizard.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
