---
title: "属性的使用与限制"
linkTitle: "属性的使用与限制"
date: 2025-06-27
weight: 10
description: >
  属性的使用与限制。
---

{{% pageinfo %}}
本文档介绍 iTop 中各种属性类型的使用限制和替代方案。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:attribute-limitation)。
{{% /pageinfo %}}

## 概述

iTop 提供了多种属性类型，但并非每种属性都能在任何地方使用。本文档说明各种限制和替代方案。

## 字段在子类上的覆盖

字段在单个类上定义，具有属性：默认值、允许值、是否必填、依赖关系等。

在每个子类上，可以：

- 定义字段的显示位置
- 覆盖标签和工具提示
- 若字段定义中不是必填，则可通过 PHP 代码仅对该子类设为必填

## 必填字段的限制

某些属性类型不能设为必填：

- **AttributeLinkedSet**：可通过 PHP 代码强制必填
- **AttributeCaselog**：仅对第一个条目有效，之后不再为空

## 更改属性类型

在已有对象的情况下更改属性类型**并非安全操作**，取决于 MySQL/MariaDB 的能力：

| 操作 | 结果 |
|------|------|
| 增大 Text 字段大小 | 支持，但 Setup 期间可能耗时 |
| 减小 Text 字段大小 | 可能导致数据截断损坏 |
| Date 改为 DateTime | 时间部分设为 00:00:00 |
| Text 改为 HTML | 建议添加 `<format>html</format>` 标签而非更改类型 |
| Duration/Integer/Decimal/Date/Datetime 改为 String | 可能可行 |
| String 改为 Duration/Integer/Decimal/Date/Datetime | 假设数据格式正确才可能可行 |
| LinkedSetIndirect 改为 LinkedSet | 对数据库无影响，可安全回退 |

## 门户限制

以下属性类型在门户中不可编辑：

- EnumSet 和 TagSet
- File 和 Image
- Duration

## 关系中的属性限制

链接类不支持以下字段类型：

- Caselog
- LinkedSet、LinkedSetIndirect
- Text、HTML、Template
- File、Image
- Duration
- TagSet、EnumSet

## 属性类型选择

### 多值选择

- **TagSet、EnumSet、LinkedSetIndirect**：允许为单个对象字段设置多个值

### 单值选择

- **Enum 或 ExternalKey**（指向 Typology 子类）：允许选择单个值

### 数据模型值 vs 数据库值

**Enum 和 EnumSet**：
- 缺点：添加新值需要 Designer MTP 或新扩展版本加 Setup
- 优点：OQL 过滤器可基于这些值，不依赖实例数据

**Typology、TagSet 和 LinkedSetIndirect**：
- 优点：添加值快速简单
- 缺点：基于这些值的 PHP 业务规则与数据耦合，文档化不足

## 更改枚举值

若在数据模型中更改 Enum 属性的允许值，而 iTop 中已有对象使用旧值：

- 数据模型视角的允许值限制为新值集合
- 每次 Setup 时，数据库视角的允许值 = 数据模型值 + 数据库中现有值
- 编辑时，可选值 = 当前值 + 所有数据模型定义值
- 搜索时，可选值仅限于数据模型定义值

## 过滤关系

### 外部键

`AttributeExternalKey` 的 `filter` XML 标签允许使用 OQL 查询过滤允许值。支持 `$this->attcode` 语法，其中 `attcode` 是当前类的有效字段 ID。

### 多对多关系

例如限制团队成员属于同一组织：

| 类 | Person | lnkPersonToTeam | Team |
|----|--------|-----------------|------|
| 字段 | teams_list | person_id / team_id | persons_list |
| 属性类型 | LinkedSetIndirect | ExternalKey | LinkedSetIndirect |
| 过滤方法 | Search Form Prefill | XML filter | XML filter |

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:attribute-limitation>

版本：3_2_0/customization/attribute-limitation.txt · Last modified: 2026/06/10 17:31 by 127.0.0.1
