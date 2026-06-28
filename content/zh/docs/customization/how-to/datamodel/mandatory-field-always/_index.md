---
title: "强制字段始终必填"
linkTitle: "强制字段始终必填"
date: 2025-06-27
weight: 10
description: >
  强制字段始终必填。
---

{{% pageinfo %}}
本文档介绍如何强制字段在所有情况下必填。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field-always)。
{{% /pageinfo %}}

## 概述

本用例强制要求在所有 PhysicalDevice 及其子类（Server、Mobile Phone、Rack、Tablet、PDU 等）上填写 "location" 字段。

## 使用 ITSM Designer（Combodo 客户）

1. 打开 PhysicalDevice 类
2. 编辑 `location_id` 字段
3. 在弹窗中勾选 **Mandatory** 复选框

## 使用 iTop 扩展

由于 `location_id` 字段直接在 PhysicalDevice 类上声明，只需将 `is_null_allowed` 设为 `false`：

```xml
<class id="PhysicalDevice">
  <fields>
    <field id="location_id">
      <is_null_allowed _delta="redefine">false</is_null_allowed>
    </field>
  </fields>
</class>
```

## 迁移注意事项

在 Setup（或工具包）时，若已有 PhysicalDevice 未记录位置，将收到错误消息。可以在 iTop 的 DB tools 菜单中重新运行此检查。修复对象不会阻止其打开和修改，但 DataSynchro 或 REST/JSON 脚本在修改其他字段时会失败。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:mandatory-field-always>

版本：3_2_0/customization/mandatory-field-always.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
