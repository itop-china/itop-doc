---
title: "隐藏影响分析"
linkTitle: "隐藏影响分析"
date: 2025-06-27
weight: 10
description: >
  隐藏对象详情页中的影响分析或仪表盘标签页。
---

{{% pageinfo %}}
本文档介绍如何隐藏对象详情页中的特定标签页（如影响分析或仪表盘）。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:hidetab)。
{{% /pageinfo %}}

## 概述

通过简单的 PHP 扩展，可以从 Change 对象（或任何其他 Ticket 类）的详情页中隐藏 "Impact analyses" 标签页，也可以根据条件隐藏仪表盘标签页。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 隐藏影响分析标签页

```php
public function DisplayBareRelations(WebPage $oPage, $bEditMode = false)
{
  parent::DisplayBareRelations($oPage, $bEditMode);
  $oPage->RemoveTab('Ticket:ImpactAnalysis');
}
```

## 根据条件隐藏仪表盘标签页

可以根据对象字段值隐藏属性仪表盘。以下示例假设 Team 类有一个代码为 `dashboard` 的 Dashboard 属性，当 `notify` 字段为 `no` 时隐藏该仪表盘：

```php
public function DisplayBareRelations(WebPage $oPage, $bEditMode = false)
{
  parent::DisplayBareRelations($oPage, $bEditMode);
  if ($this->Get('notify') === 'no') {
    $oPage->RemoveTab('Class:Team/Attribute:dashboard');
  }
}
```

## 标签页标识符

标签页标识符与字典条目一致：

- 格式：`Class:class_name/Attribute:attribute_code`
- 注意区分大小写，属性代码通常为小写

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:hidetab)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:hidetab>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/hidetab.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
