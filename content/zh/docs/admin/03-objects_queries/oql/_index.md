
---
title: "OQL"
linkTitle: "管理：OQL"
date: 2025-06-27
weight: 1
description: >
  iTop 对象查询语言（Object Query Language）简介。
---

{{% pageinfo %}}

OQL（Object Query Language）是 iTop 中用于查询对象的类 SQL 语言。更多详细文档请参考 [iTop 官方 OQL 文档](https://www.itophub.io/wiki/page?id=3_2_0:oql:start)。

{{% /pageinfo %}}

## 基本语法

```sql
SELECT ClassName WHERE condition
```

## 常用示例

```sql
-- 查询所有生产环境服务器
SELECT Server WHERE status = 'production'

-- 查询某个组织的所有人员
SELECT Person WHERE org_id = 1

-- 查询未解决工单
SELECT Ticket WHERE status != 'closed'
```

## 使用场景

- 在[运行对象查询](../..)中执行即席查询
- 在[查询手册](../..)中保存常用查询
- 在[审计规则](../../02-audit/)中定义审计条件
- 在[通知](../..)中定义触发器过滤条件

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:oql:start>

版本：3_2_0/oql/start.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
