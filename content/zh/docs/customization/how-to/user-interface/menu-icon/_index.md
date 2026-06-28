---
title: "修改菜单图标"
linkTitle: "修改菜单图标"
date: 2025-06-27
weight: 10
description: >
  使用 Font Awesome 图标自定义菜单。
---

{{% pageinfo %}}
本文档介绍如何修改 iTop 菜单组的图标。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:menu-icon)。
{{% /pageinfo %}}

## 概述

从 iTop 3.0 开始，菜单组可以显示图标（菜单折叠时显示）。可使用的图标为 Font Awesome 5 版本。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 修改菜单图标

```xml
<menu id="RequestManagement" _delta="if_exists">
  <style>
    <decoration_classes _delta="force">fas fa-briefcase-medical</decoration_classes>
  </style>
</menu>
<menu id="IncidentManagement" _delta="if_exists">
  <style>
    <decoration_classes _delta="force">fas fa-car-crash</decoration_classes>
  </style>
</menu>
<menu id="ProblemManagement" _delta="if_exists">
  <style>
    <decoration_classes _delta="force">fas fa-ambulance</decoration_classes>
  </style>
</menu>
<menu id="ChangeManagement" _delta="if_exists">
  <style>
    <decoration_classes _delta="force">fas fa-random</decoration_classes>
  </style>
</menu>
<menu id="SystemTools" _delta="if_exists">
  <style>
    <decoration_classes _delta="force">fab fa-expeditedssl</decoration_classes>
  </style>
</menu>
<menu id="ConfigurationTools" _delta="if_exists">
  <style _delta="force">
    <decoration_classes>fas fa-mail-bulk</decoration_classes>
  </style>
</menu>
```

## 查找图标

- 使用 [Font Awesome 5 Free](https://fontawesome.com/v5/search?o=r&m=free) 图标库
- 图标类格式为 `fas fa-icon-name`（solid）或 `far fa-icon-name`（regular）或 `fab fa-icon-name`（brand）

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:menu-icon)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:menu-icon>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/menu-icon.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
