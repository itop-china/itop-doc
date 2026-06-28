---
title: "添加对象概览"
linkTitle: "添加对象概览"
date: 2025-06-27
weight: 10
description: >
  定义对象摘要卡片，悬停时显示更多信息。
---

{{% pageinfo %}}
本文档介绍如何定义对象摘要卡片，在悬停时显示更多信息。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:summary-card)。
{{% /pageinfo %}}

## 概述

iTop 3.1 引入了对象摘要卡片功能。在对象列表或详情页中，外部链接仅显示 friendlyname，虽然可以点击打开详情，但用户可能希望在不打开的情况下看到更多信息。摘要卡片就是解决方案。

在编辑模式下，要区分下拉列表中的同名对象，请使用 [complementary name](../longname/)。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 功能特性

- 每个对象类可以定义一个摘要
- 当定义了摘要卡片时，鼠标悬停在 friendlyname 上超过一定延迟后，会显示弹出窗口，包含：
  - 对象图标
  - friendlyname
  - 语义属性（如已定义）
  - 类名
  - 直接编辑或查看对象的菜单（取决于用户权限）
  - XML 摘要展示中指定的其他字段
- 如果在类层次结构的不同级别定义了摘要，将使用最接近当前对象类的摘要
- 如果显示的某个字段是外部键，且该对象也定义了摘要，则可以级联打开摘要弹出窗口

iTop 默认数据模型已为少数类定义了摘要卡片，您可以修改它们或为尚未定义的类创建新的摘要。

## XML 定义

```xml
<presentation>
  <summary _delta="define">
    <items>
      <item id="function">
        <rank>10</rank>
      </item>
      <item id="phone">
        <rank>20</rank>
      </item>
      <item id="email">
        <rank>30</rank>
      </item>
      <item id="location_id">
        <rank>40</rank>
      </item>
      <item id="org_id">
        <rank>50</rank>
      </item>
    </items>
  </summary>
</presentation>
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:summary-card)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:summary-card>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/summary-card.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
