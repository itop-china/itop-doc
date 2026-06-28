---
title: "修改主色调"
linkTitle: "修改主色调"
date: 2025-06-27
weight: 10
description: >
  修改 iTop 控制台的主色调。
---

{{% pageinfo %}}
本文档介绍如何修改 iTop 控制台的主色调，以匹配企业品牌色。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:change-main-color)。
{{% /pageinfo %}}

## 概述

通过 ITSM Designer 或 XML 扩展，可以修改 iTop 控制台中按钮、搜索横幅、悬停行和超链接的颜色，使其与企业品牌色保持一致。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 标准主色调变量

iTop 3.0 使用 SCSS 变量系统定义主色调。以下是一组标准的主色调变量：

```xml
<variables>
  <variable id="ibo-color-primary-100" _delta="define">$ibo-color-blue-100</variable>
  <variable id="ibo-color-primary-200" _delta="define">$ibo-color-blue-100</variable>
  <variable id="ibo-color-primary-300" _delta="define">$ibo-color-blue-300</variable>
  <variable id="ibo-color-primary-400" _delta="define">$ibo-color-blue-400</variable>
  <variable id="ibo-color-primary-500" _delta="define">$ibo-color-blue-500</variable>
  <variable id="ibo-color-primary-600" _delta="define">$ibo-color-blue-500</variable>
  <variable id="ibo-color-primary-700" _delta="define">$ibo-color-blue-600</variable>
  <variable id="ibo-color-primary-800" _delta="define">$ibo-color-blue-800</variable>
  <variable id="ibo-color-primary-900" _delta="define">$ibo-color-blue-900</variable>
</variables>
```

## 自定义颜色

将上述 XML 代码粘贴到 ITSM Designer 或扩展中，将 `$ibo-color-blue-XXX` 替换为所需的颜色变量或具体颜色值。

### 颜色格式

支持的颜色格式包括：

- 颜色名称：`purple`
- 十六进制：`#FF0000`
- RGB：`rgb(123, 123, 132)`
- RGBA：`rgba(123, 123, 123, 0.5)`
- HSL：`hsl(123, 50%, 50%)`
- HSLA：`hsla(123, 50%, 50%, 0.23)`
- SCSS 变量：`$ibo-color-transparent`、`$ibo-body-text-color` 等

### 使用现有变量

使用 iTop 现有 SCSS 变量的优势在于，当创建或修改主题时，这些设置会自动应用，保持界面一致性。

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:change-main-color)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:change-main-color>

版本：3_2_0/customization/change-main-color.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
