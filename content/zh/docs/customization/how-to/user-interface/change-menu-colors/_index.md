---
title: "修改左侧菜单颜色"
linkTitle: "修改左侧菜单颜色"
date: 2025-06-27
weight: 10
description: >
  修改 iTop 控制台左侧导航菜单的颜色。
---

{{% pageinfo %}}
本文档介绍如何修改 iTop 控制台左侧导航菜单的颜色，以匹配企业品牌色。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:change-menu-colors)。
{{% /pageinfo %}}

## 概述

通过 ITSM Designer 或 XML 扩展，可以修改 iTop 控制台左侧菜单的颜色，使其与企业品牌色保持一致。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 菜单颜色变量

以下 XML 代码展示了控制左侧菜单各部分的 SCSS 变量：

```xml
<variables>
  <!-- 主菜单（图标使用与文本相同的颜色） -->
  <variable id="ibo-navigation-menu--body--background-color" _delta="define">$ibo-color-white-100</variable>
  <variable id="ibo-navigation-menu--body--text-color" _delta="define">$ibo-color-blue-800</variable>

  <!-- 主菜单悬停效果（背景与文本） -->
  <variable id="ibo-navigation-menu--action--background-color--on-hover" _delta="define">$ibo-color-blue-100</variable>
  <variable id="ibo-navigation-menu--action--text-color--on-hover" _delta="define">$ibo-color-blue-700</variable>

  <!-- 主菜单激活状态（图标与文本） -->
  <variable id="ibo-navigation-menu--menu-group-title--text-color--is-active" _delta="define">$ibo-color-blue-700</variable>
  <variable id="ibo-navigation-menu--menu-group-icon--text-color--is-active" _delta="define">$ibo-color-blue-500</variable>

  <!-- 子菜单（菜单组文本、数字和悬停背景） -->
  <variable id="ibo-navigation-menu--menu-node--background-color" _delta="define">$ibo-color-blue-100</variable>
  <variable id="ibo-navigation-menu--menu-node--text-color" _delta="define">$ibo-color-blue-900</variable>

  <!-- 底部菜单（用户图标下方） -->
  <variable id="ibo-navigation-menu--bottom-part--background-color" _delta="define">$ibo-color-grey-100</variable>
  <variable id="ibo-navigation-menu--user--text-color" _delta="define">$ibo-color-blue-800</variable>
  <variable id="ibo-navigation-menu--user-organization--text-color" _delta="define">$ibo-color-blue-600</variable>
</variables>
```

## 其他菜单变量

以下变量目前可能没有明显的视觉效果：

```xml
<variables>
  <variable id="ibo-navigation-menu--action-icon--text-color--on-hover" _delta="define">$ibo-color-red-300</variable>
  <variable id="ibo-navigation-menu--user-picture--background-color" _delta="define">$ibo-color-cyan-300</variable>
  <variable id="ibo-navigation-menu--action--background-color--on-active" _delta="define">$ibo-color-orange-300</variable>
</variables>
```

## 使用方法

将上述 XML 代码插入到扩展中，或粘贴到 ITSM Designer 中，然后修改变量值为所需的颜色。

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:change-menu-colors)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:change-menu-colors>

版本：3_2_0/customization/change-menu-colors.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
