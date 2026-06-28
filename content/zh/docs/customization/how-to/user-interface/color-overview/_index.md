---
title: "修改颜色等"
linkTitle: "修改颜色等"
date: 2025-06-27
weight: 10
description: >
  全面修改 iTop 的颜色方案。
---

{{% pageinfo %}}
本文档介绍修改 iTop 控制台颜色的多种方案，从简单的颜色替换到完整的自定义主题。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:color-overview)。
{{% /pageinfo %}}

## 概述

本教程介绍修改 iTop 控制台颜色的不同方案，从简单的 ITSM Designer 修改到编写完整的自定义 CSS 主题。

## 对象颜色

### 替换默认橙色

iTop 在 `full-moon` 主题中使用从浅到深的橙色渐变。可以轻松替换为其他颜色渐变：

- [修改主色调](../change-main-color/)

### 状态颜色

iTop 可以为每个状态值关联颜色和图标。默认数据模型中已定义许多状态颜色，您也可以修改或添加：

- [高亮状态](../enum-colors/)

### 类颜色

iTop 为每个类使用特定颜色，在对象显示中使用：

- [类颜色与图标](../class-colors/)

### 列表高亮

在对象列表中，可以为某些对象设置背景色以便快速识别：

- [高亮关键对象](../highlight-critical-objects/)

## 菜单图标与颜色

- [修改菜单图标](../menu-icon/)
- [修改左侧菜单颜色](../change-menu-colors/)
- [创建主题](../theme/)

## 颜色格式

支持的颜色代码格式：

| 格式 | 示例 |
|------|------|
| 十六进制 | `#FF0000` |
| RGB | `rgb(123, 123, 132)` |
| RGBA | `rgba(123, 123, 123, 0.5)` |
| HSL | `hsl(123, 50%, 50%)` |
| HSLA | `hsla(123, 50%, 50%, 0.23)` |
| SCSS 变量 | `$ibo-color-transparent`、`$ibo-body-text-color` 等 |

### 使用现有 SCSS 变量

使用 iTop 现有 SCSS 变量的优势在于，当创建或修改主题时，这些设置会自动应用，保持界面一致性。

要使用现有 iTop 颜色代码，可以在 iTop 3.0+ 中使用浏览器开发工具查看现有值，然后使用以下语法转换：

- `$ibo-lifecycle-success-state-primary-color`
- `var(--ibo-lifecycle-success-state-primary-color)`

## 其他变量

### 标签最大宽度

如果标签值较长且不希望被截断，可以修改变量 `$ibo-input-set--item--max-width`，修改方式与颜色变量类似。

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:color-overview)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:color-overview>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/color-overview.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
