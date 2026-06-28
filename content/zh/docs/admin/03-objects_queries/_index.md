---
title: "运行对象查询"
linkTitle: "管理：运行对象查询"
date: 2025-06-26
weight: 14
description: >
  <br> ➡️ 使用 OQL 查询获取符合特定条件的对象集
---

{{% pageinfo %}}

使用 OQL 获取符合特定条件的对象集。

{{% /pageinfo %}}

## 使用

"管理工具 / 运行对象查询" → 输入 OQL → "执行"

```sql
SELECT Server WHERE status = 'production'
SELECT Ticket WHERE contacts_list = ''
```

> 参考 [OQL 文档](https://www.itophub.io/wiki/page?id=3_2_0:oql:start)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:objects_queries>

版本：3_2_0/admin/objects_queries.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
