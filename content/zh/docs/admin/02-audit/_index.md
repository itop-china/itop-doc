---
title: "审计 CMDB"
linkTitle: "管理：审计 CMDB"
date: 2025-06-26
weight: 13
description: >
  <br> ➡️ 使用审计规则检查 iTop 数据库中存储信息的一致性
---

{{% pageinfo %}}

"审计"用于检查 iTop 数据库中信息的一致性。如"生产环境设备是否都有支持合同？"或"所有服务器位置是否已知？"

**审计规则**分组到**审计类别**中。类别定义对象范围（OQL 查询），规则定义约束（也是 OQL）。

{{% /pageinfo %}}

## 审计报告

点击"数据管理 / 审计"运行。每类显示：对象数、错误数、正确率。每条规则显示错误对象数。

## 管理审计类别

"管理"菜单 → "审计类别"，由名称、描述和定义集（OQL）组成。

## 管理审计规则

规则由名称、描述、查询和 `有效对象？` 标志定义：

- `有效对象？` = `否`：查询返回的对象标红（错误对象）
- `有效对象？` = `是`：查询返回的对象不标红（有效对象）

### 示例

**无成员的团队**（`有效对象？` = `否`）

```sql
SELECT Team AS t JOIN lnkPersonToTeam AS l1 ON l1.team_id=t.id WHERE l1.person_id != 0
```

**通知=是但无邮箱的人员**（`有效对象？` = `是`）

```sql
SELECT Person WHERE notify = 'yes' AND email = ""
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:audit>

版本：3_2_0/admin/audit.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
