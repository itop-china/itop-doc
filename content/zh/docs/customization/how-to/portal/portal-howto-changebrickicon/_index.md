---
title: "修改菜单图标"
linkTitle: "修改菜单图标"
date: 2025-06-27
weight: 10
description: >
  修改菜单图标。
---

{{% pageinfo %}}
本文档介绍如何修改门户中 Brick 的图标。通过修改门户 XML 配置中的 `decoration_class` 属性，可以将默认图标替换为 FontAwesome 图标。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_changebrickicon)。
{{% /pageinfo %}}

## 概述

在本教程中，我们将"New request"（新请求）的图标从对话气泡改为纸飞机。

## 前提条件

- 知道如何制作 iTop 扩展并升级系统
- 拥有安装了演示数据和增强版门户的 iTop 系统
- 拥有足够权限访问门户的账户（通常需要 "Portal User" 角色）

## 教程目标

在本教程中，您将学习如何：

- 修改 "New request" Brick 的图标

## 分步说明

### 1. 创建扩展

首先，创建一个将修改门户 XML 配置以更改 Brick 图标的 iTop 扩展。如有必要，请查看定制指南中的[扩展模块](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)部分。

- 将扩展命名为 `sample-portal-change-brick-icon`
- 删除 `main.sample-portal-change-brick-icon.php` 文件，因为我们不需要 PHP 代码
- 删除 `*.dict.sample-portal-change-brick-icon.php` 文件，因为我们不需要翻译

### 2. 修改门户配置

现在扩展已准备好，我们只需要制作一个 XML delta 并更改门户配置以定义要使用的图标。打开 `datamodel.sample-portal-change-brick-icon.xml` 文件并粘贴以下代码：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<itop_design xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.7">
  <module_designs>
    <module_design id="itop-portal">
      <bricks>
        <brick id="services">
          <decoration_class>
            <default _delta="force">fas fa-paper-plane fa-2x fa-fw</default>
          </decoration_class>
        </brick>
      </bricks>
    </module_design>
  </module_designs>
</itop_design>
```

这重新定义了 `services`（即"New request"）Brick 的图标。关键部分：

- `fas fa-paper-plane`：图标类，可在 [FontAwesome v5 网站](https://fontawesome.com/)（仅限免费类别）上找到
- `fa-2x`：确保图标在导航菜单中与其他图标大小相同
- `fa-fw`：确保图标在导航菜单中与其他图标一样居中

### 3. 升级系统

最后，使用新扩展选项运行 iTop 系统升级并访问门户。您应该看到 "New request" 图标已被我们的纸飞机替换。

## 下载

您可以在我们的 GitHub 上找到此扩展。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_changebrickicon>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/portal_howto_changebrickicon.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
