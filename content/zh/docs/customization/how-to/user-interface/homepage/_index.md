---
title: "修改 iTop 首页"
linkTitle: "修改 iTop 首页"
date: 2025-06-27
weight: 10
description: >
  将 iTop 控制台首页重定向到任意页面。
---

{{% pageinfo %}}
本文档介绍如何修改 iTop 控制台的首页。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:homepage)。
{{% /pageinfo %}}

## 概述

通过简单的 XML 扩展，可以将 iTop 控制台的首页重定向到任何其他 iTop 页面。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 使用 XML 扩展

```xml
<portals>
  <portal id="backoffice">
    <url _delta="redefine">pages/somepage.php</url>
  </portal>
</portals>
```

- `backoffice` 是控制台的名称，在 iTop 中控制台被视为一种门户
- 此机制适用于任何 iTop 门户，只需知道其 ID 即可。对于 iTop 用户门户，ID 为 `itop-portal`

## 使用配置参数

不使用扩展的替代方案是使用配置参数 `portal_dispatch_urls`。

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:homepage)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:homepage>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/homepage.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
