---
title: "修改页面标题"
linkTitle: "修改页面标题"
date: 2025-06-27
weight: 10
description: >
  自定义对象详情页的浏览器标签页标题。
---

{{% pageinfo %}}
本文档介绍如何修改 iTop 对象详情页的浏览器标签页标题。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:tab-title)。
{{% /pageinfo %}}

## 概述

通过简单的 XML 扩展，可以重新定义 iTop 控制台中对象详情页的浏览器标签页标题。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 控制台页面标题

```php
'UI:DetailsPageTitle' => ITOP_APPLICATION_SHORT.' - %2$s - Détails de %1$s',
```

`%1$s` 对应 friendlyname 的第一个属性。

## 门户页面标题

- 门户首页使用字典条目 `Page:DefaultTitle`，可以修改
- 其他页面的标题是 Brick 标签和应用程序短名称的组合，例如：`Open Requests - iTop`。此标题无法更改
- 全屏修改对象时的标题为 `Updating R-000012 (UserRequest) - iTop`。此标题无法更改

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:tab-title)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:tab-title>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/tab-title.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
