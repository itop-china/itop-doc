---
title: "修改 Bootstrap 主题"
linkTitle: "修改 Bootstrap 主题"
date: 2025-06-27
weight: 10
description: >
  修改 Bootstrap 主题。
---

{{% pageinfo %}}
本文档介绍如何替换门户的默认 Bootstrap 主题。通过创建扩展并添加自定义 CSS 主题文件，可以更改门户的整体外观。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_changebstheme)。
{{% /pageinfo %}}

## 概述

在本教程中，默认门户的 Bootstrap 主题（Combodo 主题）将被在线找到的另一个主题替换。

## 前提条件

- 知道如何制作 iTop 扩展并升级系统
- 拥有安装了演示数据和增强版门户的 iTop 系统
- 拥有足够权限访问门户的账户（通常需要 "Portal User" 角色）

## 教程目标

在本教程中，您将学习如何：

- 更改门户的 Bootstrap 主题以改变其外观和感觉

## 分步说明

### 1. 创建扩展

首先，创建一个将修改门户 XML 配置以定义使用哪个主题的 iTop 扩展。如有必要，请查看定制指南中的[扩展模块](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)部分。

- 将扩展命名为 `sample-portal-new-theme`
- 删除 `main.sample-portal-new-theme.php` 文件，因为我们不需要 PHP 代码

### 2. 选择新主题

现在扩展已创建，我们需要获取一个新的 Bootstrap 主题来替换 Combodo 主题。在本示例中，我们将使用 [bootswatch.com](https://bootswatch.com/) 上的 **Simplex** 主题，但您可以使用任何与 Bootstrap 3 兼容的主题。

前往 [bootswatch.com](https://bootswatch.com/)，下载预编译的 CSS 文件，并将其放入新扩展的文件夹中。

### 3. 修改门户配置

现在新主题已准备好，我们只需要制作一个 XML delta 并更改门户配置以使用它。打开 `datamodel.sample-portal-new-theme.xml` 文件并粘贴以下代码：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.3">
  <module_designs>
    <module_design id="itop-portal" xsi:type="portal">
      <properties>
        <themes>
          <theme id="bootstrap" _delta="define_if_not_exists">sample-portal-new-theme/css/bootstrap.min.css</theme>
        </themes>
      </properties>
    </module_design>
  </module_designs>
</itop_design>
```

这向门户添加了一个 `theme` 节点。确保包含扩展和文件名的路径与您的系统一致。

### 4. 升级系统

最后，使用新扩展选项运行 iTop 系统升级并访问门户。

Et voilà !（完成了！）

## 下载

您可以在以下地址找到此扩展及一些示例主题：`sample-portal-new-theme-1.0.1-147.zip`

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_changebstheme>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/portal_howto_changebstheme.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
