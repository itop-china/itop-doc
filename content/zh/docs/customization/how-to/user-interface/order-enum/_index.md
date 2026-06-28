---
title: "排序枚举值"
linkTitle: "排序枚举值"
date: 2025-06-27
weight: 10
description: >
  自定义枚举属性值的显示顺序。
---

{{% pageinfo %}}
本文档介绍如何自定义枚举属性值的显示顺序。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:order-enum)。
{{% /pageinfo %}}

## 概述

iTop 3.1 引入了枚举属性值排序的新功能。

在 3.1 版本之前，枚举值按代码的字母顺序排序。

现在可以在 XML 中通过 `sort_type` 标签指定排序方式：

- **code**（默认）：与 3.1 之前的行为相同，按代码字母顺序排序
- **label**：按标签的字母顺序排序（不同语言可能有不同的顺序）
- **rank**：假设为每个值指定了 rank。有 rank 的值优先显示，按 rank 排序；没有 rank 的值随后按代码字母顺序排序

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 按标签排序

```xml
<field id="origin" xsi:type="AttributeEnum">
  <sort_type>label</sort_type>
  <values>
    <value id="in_person"><code>in_person</code></value>
    <value id="chat"><code>chat</code></value>
    <value id="mail"><code>mail</code></value>
    <value id="phone"><code>phone</code></value>
    <value id="portal"><code>portal</code></value>
    <value id="monitoring"><code>monitoring</code></value>
  </values>
  <sql>origin</sql>
  <default_value>phone</default_value>
  <is_null_allowed>true</is_null_allowed>
  <display_style>list</display_style>
</field>
```

## 按 Rank 排序

```xml
<field id="status" xsi:type="AttributeEnum">
  <always_load_in_tables>true</always_load_in_tables>
  <sort_type>rank</sort_type>
  <values>
    <value id="new">
      <code>new</code>
      <rank>10</rank>
      <style>
        <main_color>$ibo-lifecycle-new-state-primary-color</main_color>
        <complementary_color>$ibo-lifecycle-new-state-secondary-color</complementary_color>
        <decoration_classes/>
      </style>
    </value>
    <value id="waiting_for_approval">
      <code>waiting_for_approval</code>
      <rank>20</rank>
      <style>
        <main_color>$ibo-lifecycle-waiting-state-primary-color</main_color>
        <complementary_color>$ibo-lifecycle-waiting-state-secondary-color</complementary_color>
        <decoration_classes>fas fa-hourglass-half</decoration_classes>
      </style>
    </value>
    <value id="approved">
      <code>approved</code>
      <rank>30</rank>
      <style>
        <main_color>$ibo-lifecycle-success-state-primary-color</main_color>
        <complementary_color>$ibo-lifecycle-success-state-secondary-color</complementary_color>
        <decoration_classes>fas fa-user-check</decoration_classes>
      </style>
    </value>
    <!-- ... 其他值 -->
  </values>
</field>
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:order-enum)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:order-enum>

版本：3_2_0/customization/order-enum.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
