---
title: "定义废弃规则"
linkTitle: "定义废弃规则"
date: 2025-06-27
weight: 10
description: >
  为类定义废弃条件，标记过时对象。
---

{{% pageinfo %}}
本文档介绍如何为 iTop 类定义废弃规则，自动标记过时对象。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:obsolescence)。
{{% /pageinfo %}}

## 概述

废弃规则用于自动标记不再活跃或过时的对象。在使用废弃功能前，请先了解 [Obsolescence](../../../../admin/object-obsolescence/) 的基本概念。

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 定义方式

- 废弃规则按类定义
- 废弃条件是一个 OQL 表达式，可以使用类的任何字段，包括 `AttributeExternalField` 类型
- 废弃条件从父类继承，但可以在子类上重新定义
- 如果类及其父类都未定义废弃条件，则该类的对象永远不会被视为过时

## 基本示例

```xml
<properties>
  <obsolescence _delta="redefine">
    <condition><![CDATA[status='inactive']]></condition>
  </obsolescence>
</properties>
```

处理空值：

```xml
<obsolescence _delta="redefine">
  <condition><![CDATA[status='inactive' OR ISNULL(status)=1]]></condition>
</obsolescence>
```

## 复杂示例

### 基于对象状态结合父对象状态

```xml
<condition>
  <![CDATA[status = 'obsolete' OR (server_id != 0 AND server_id_obsolescence_flag)]]>
</condition>
```

### 结合状态和延迟时间

```xml
<condition>
  <![CDATA[
   operational_status='closed' 
  AND 
  ( close_date < DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 15 MONTH),'%Y-%m-%d 00:00:00') 
    OR
    (
       ISNULL(close_date) 
      AND 
       last_update < DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 15 MONTH),'%Y-%m-%d 00:00:00')
    )
  )]]>
</condition>
```

此示例标记关闭超过 15 个月的对象为过时。

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:obsolescence)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:obsolescence>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/obsolescence.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
