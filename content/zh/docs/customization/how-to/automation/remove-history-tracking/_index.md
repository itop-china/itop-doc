---
title: "移除历史追踪"
linkTitle: "移除历史追踪"
date: 2025-06-27
weight: 10
description: >
  移除历史追踪。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中为计数器字段停用历史追踪。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-counter#deactivate_history_tracking)。
{{% /pageinfo %}}

## 目标

为计数器字段停用历史追踪，避免在历史记录中记录每次计数器变更。

## 适用场景

- 不断变化的值，由外部来源控制
- 计算计数器，其修改日期可能无用

## 实现方法

向字段定义添加 `<tracking_level>none</tracking_level>`：

```xml
<field id="reopen_count">
  <!-- 无追踪级别，表示该字段的变更不记录在历史日志中 -->
  <tracking_level>none</tracking_level>
</field>
```

如果不定义该标签，iTop 将默认追踪该字段的变更。

## 完整示例

在[统计工单重开次数](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-counter)教程中，完整的计数器字段定义如下：

```xml
<classes>
  <class id="UserRequest" _delta="must_exist">
    <fields>
      <field id="reopen_count" xsi:type="AttributeInteger" _delta="define">
        <sql>reopen_count</sql>
        <default_value>0</default_value>
        <is_null_allowed>true</is_null_allowed>
        <tracking_level>none</tracking_level>
      </field>
    </fields>
  </class>
</classes>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-counter#deactivate_history_tracking>

版本：3_2_0/customization/add-counter.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
