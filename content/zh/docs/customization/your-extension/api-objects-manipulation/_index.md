---
title: "对象操作 API"
linkTitle: "对象操作 API"
date: 2025-06-27
weight: 10
description: >
  对象操作 API。
---

{{% pageinfo %}}
本文档介绍 iTop 中用于搜索和操作持久化对象的 API 类。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:api:objects-manipulation:start)。
{{% /pageinfo %}}

## 概述

iTop 提供了一组核心类用于在数据库中搜索和操作对象。这些类构成了 ORM（对象关系映射）层的基础。

## 核心类

### DBObjectSearch

`DBObjectSearch` 类用于在数据库中搜索对象。它允许您构建 OQL（对象查询语言）查询来检索满足特定条件的对象。

### DBObjectSet

`DBObjectSet` 类表示一组持久化对象。它是执行查询后的结果集，提供了遍历和操作这些对象的方法。

### DBUnionSearch

`DBUnionSearch` 类用于执行多个 `DBObjectSearch` 的并集操作。当您需要合并来自不同查询的结果时，可以使用此类。

## 参考

- [iTop 官方文档 - 对象操作 API](https://www.itophub.io/wiki/page?id=3_2_0:customization:api:objects-manipulation:start)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:api:objects-manipulation:start>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/api/objects-manipulation/start.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
