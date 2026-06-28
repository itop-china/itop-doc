---
title: "门户限制"
linkTitle: "门户限制"
date: 2025-06-27
weight: 10
description: >
  门户限制。
---

{{% pageinfo %}}
本文档介绍 iTop 门户的当前已知限制。在定制门户时，了解这些限制非常重要。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_limitations)。
{{% /pageinfo %}}

## 概述

以下是定制门户时应了解的一些新门户限制。这些限制可能会在未来版本中改变。

## 安全 / 访问权限

通过门户创建或编辑对象时，必须满足多个条件，提交才能被服务器接受：

- 对象必须包含在该用户和类的门户**可写范围**中 — 此限制**无法禁用**
- 所有可编辑的 **AttributeExternalKey** 字段必须引用用户有权查看的对象 — 此限制**无法禁用**

要授予用户在门户中查看对象的权限：

- 对象必须包含在该用户和类的**门户范围**中
- **并且**：对象属于用户的 **allowed_orgs**，**或**范围设置为 **ignore_silo**，**或**对象类**没有** `org_id` 字段

## 归档对象

归档对象在**任何**用户门户中**永远不可见**，目前没有计划改变这一点。

## 组织

默认门户中没有定义用于显示组织的表单，因此**所有**组织字段都会显示。如果要限制门户用户可见的组织字段，则需要在 iTop 扩展中定义表单。

## 表单

### 字段

某些属性类型在门户中不可编辑：

- EnumSet 和 TagSet
- File 和 Image
- Duration

### 对象搜索

从 ExternalKey 或 LinkedSet 类型的属性搜索对象时，**过滤器**在 Date / DateTime / Duration / Deadline / HTML 类型的属性上不起作用。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_limitations>

版本：3_2_0/customization/portal_limitations.txt · Last modified: 2026/06/10 17:31 by 127.0.0.1
