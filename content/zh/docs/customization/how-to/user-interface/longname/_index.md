---
title: "区分同名对象"
linkTitle: "区分同名对象"
date: 2025-06-27
weight: 10
description: >
  通过补充属性区分同名对象。
---

{{% pageinfo %}}
本文档介绍如何在编辑外部键时区分同名对象。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:longname)。
{{% /pageinfo %}}

## 概述

iTop 3.0 引入了区分同名对象的新功能。在编辑外部键选择远程对象时，可以显示除 friendlyname 之外的其他属性。

在只读模式下，从 iTop 3.1 开始可以通过添加 [summary card](../summary-card/) 来实现相同目标。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 使用补充属性

在 XML 中为目标类指定 `complementary_attributes`，选择下拉列表时将显示额外属性：

```xml
<properties>
  <naming>
    <attributes>
      <attribute id="first_name"/>
      <attribute id="name"/>
    </attributes>
    <complementary_attributes _delta="force">
      <attribute id="email"/>
      <attribute id="org_name"/>
    </complementary_attributes>
  </naming>
  <fields_semantic>
    <image_attribute>picture</image_attribute>
    <main_color/><!-- 类的主色调，CSS 格式 -->
    <complementary_color/>
  </fields_semantic>
  <style>
    <icon>../../images/icons/icons8-person-female.svg</icon>
  </style>
</properties>
```

注意：使用 `org_id` 会显示数字，对 iTop 用户没有帮助，因此最好指定 `org_name`（人类可读）。

## 自定义显示格式

可以通过字典条目为补充字段指定格式：

```xml
<dictionaries>
  <dictionary id="EN US" _delta="must_exist">
    <entries>
      <entry id="Class:Person/ComplementaryName" _delta="force"><![CDATA[%1$s - (%2$s)]]></entry>
    </entries>
  </dictionary>
</dictionaries>
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:longname)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:longname>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/longname.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
