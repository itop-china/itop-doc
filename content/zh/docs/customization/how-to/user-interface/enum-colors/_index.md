---
title: "高亮状态"
linkTitle: "高亮状态"
date: 2025-06-27
weight: 10
description: >
  为枚举值设置颜色和图标。
---

{{% pageinfo %}}
本文档介绍如何为枚举属性的值设置颜色和图标，以突出显示特定状态。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:enum-colors)。
{{% /pageinfo %}}

## 概述

iTop 3.0 引入了为枚举值设置颜色和图标的新功能。在单独显示对象或在列表中显示时，特定枚举值会以彩色标签形式呈现。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 使用 ITSM Designer

如果您与 Combodo 有支持合同，可以在 ITSM Designer 中通过以下步骤修改枚举颜色：

1. 打开 ITSM Designer
2. 在 "Classes" 标签页中打开目标类
3. 选择枚举字段
4. 点击要自定义的值对应的铅笔图标
5. 设置颜色和图标（可通过帮助链接查找图标代码）
6. 确认
7. 对每个要修改的值重复上述步骤
8. 将修改推送到 iTop 实例

## 使用扩展

### 值样式

在 `datamodel.xxxx.xml` 文件中，为枚举值添加 `style` 标签。注意以下三个子标签都是必需的：

- `main_color`：主色调（CSS 颜色或 SCSS 变量）
- `complementary_color`：辅助色
- `decoration_classes`：装饰图标类（Font Awesome V5 Free），可以为空但必须存在

```xml
<field id="priority" xsi:type="AttributeEnum">
  <sql>priority</sql>
  <values>
    <value id="must">
      <code>must</code>
      <style>
        <main_color>#234268</main_color>
        <complementary_color>$ibo-body-text-color</complementary_color>
        <decoration_classes>fas fa-chess-king</decoration_classes>
      </style>
    </value>
    <value id="want">
      <code>want</code>
      <style>
        <main_color>$ibo-color-blue-400</main_color>
        <complementary_color>white</complementary_color>
        <decoration_classes/>
      </style>
    </value>
  </values>
</field>
```

### 使用默认值

以下示例展示如何仅提供图标而不使用其他高亮效果，使用透明背景和默认文本颜色：

```xml
<field id="status" xsi:type="AttributeEnum">
  <sql>status</sql>
  <values>
    <value id="planned">
      <code>planned</code>
    </value>
    <value id="development">
      <code>development</code>
    </value>
    <value id="delivered">
      <code>delivered</code>
      <style>
        <main_color>$ibo-color-transparent</main_color>
        <complementary_color>$ibo-body-text-color</complementary_color>
        <decoration_classes>far fa-bell</decoration_classes>
      </style>
    </value>
    <value id="obsolete">
      <code>obsolete</code>
    </value>
  </values>
  <default_style>
    <main_color>$ibo-color-transparent</main_color>
    <complementary_color>$ibo-body-text-color</complementary_color>
    <decoration_classes>far fa-bell-slash</decoration_classes>
  </default_style>
  <default_value>planned</default_value>
  <is_null_allowed>false</is_null_allowed>
  <display_style>list</display_style>
  <dependencies/>
</field>
```

## iTop 默认设置

以下是 iTop Community 版本中 UserRequest 类的默认状态颜色设置：

| 值代码 | 颜色 | 图标 |
|--------|------|------|
| new | #2C5382（深蓝色） | 无 |
| assigned | #2C5382（深蓝色） | 无 |
| waiting_for_approval | #F6AE55（橙色） | fas fa-hourglass-half |
| pending | #F6AE55（橙色） | fas fa-hourglass-half |
| approved | #689F38（绿色） | fas fa-user-check |
| resolved | #689F38（绿色） | fas fa-check |
| closed | #689F38（绿色） | 无 |
| rejected | #B83280（紫色） | fas fa-user-times |
| escalated_tto | #B83280（紫色） | fas fa-fire |
| escalated_ttr | #B83280（紫色） | fas fa-fire |
| <default> | #2B6CB0（蓝色） | fas fa-user-check |

```xml
<field id="status" xsi:type="AttributeEnum">
  <values>
    <value id="new">
      <style _delta="define">
        <main_color>#2C5382</main_color>
        <complementary_color>#FFFFFF</complementary_color>
        <decoration_classes/>
      </style>
    </value>
    <value id="waiting_for_approval">
      <style _delta="define">
        <main_color>#F6AE55</main_color>
        <complementary_color>#FFFFFF</complementary_color>
        <decoration_classes>fas fa-hourglass-half</decoration_classes>
      </style>
    </value>
    <!-- ... 其他值 -->
  </values>
</field>
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:enum-colors)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:enum-colors>

版本：3_2_0/customization/enum-colors.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
