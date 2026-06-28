---
title: "标识测试实例"
linkTitle: "标识测试实例"
date: 2025-06-27
weight: 20
description: >
  介绍如何通过主题颜色和标记信息来标识 iTop 测试实例，以及 iTop 标记（Markup）功能的使用。
---

{{% pageinfo %}}
本文档介绍如何标识 iTop 测试实例以及 iTop 标记功能。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:feature:markup)。
{{% /pageinfo %}}

## 标识测试实例

iTop 默认使用 `light-grey` 主题来定义控制台的外观。我们添加了一个新主题 `test-red`，以便一眼识别您的测试实例。

### 如何更改主题

```php
'backoffice_default_theme' => 'test-red',
```

## 更改控制台颜色

您可以通过扩展或（对于 Combodo 客户）使用 ITSM Designer 来修改控制台颜色。

## iTop 标记（Markup）

从 2.7 版本起，我们在一些页面（控制台和门户）中添加了标记信息。

### 部分标记内容

对象详情上添加的标记：

- `class="object-details"`
- `data-object-class="UserRequest"`
- `data-object-id="34"`
- `data-object-mode="view"` 或 `"edit"`

对象详情中字段上添加的标记：

- `data-attribute-type="AttributeEnum"`
- `data-attribute-code="status"`
- `data-value-raw="new"` — 对于枚举类型，这是代码而非翻译后的值

对象列表中行上添加的标记：

对象列表中字段上添加的标记：

### 自定义

借助添加的 HTML 标记，您可以编写简洁的代码来修改对象在 iTop 中的显示方式。例如：在控制台中高亮显示状态。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:feature:markup>

版本：3_2_0/feature/markup.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
