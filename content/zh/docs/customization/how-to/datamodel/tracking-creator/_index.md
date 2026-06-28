---
title: "追踪对象创建者"
linkTitle: "追踪对象创建者"
date: 2025-06-27
weight: 10
description: >
  追踪对象创建者。
---

{{% pageinfo %}}
本文档介绍如何追踪对象的创建者。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:tracking-creator)。
{{% /pageinfo %}}

## 概述

对象历史记录中包含创建者信息，但难以通过 OQL 查询，也无法构建按创建者统计的仪表盘。解决方案：

- 在 Ticket 或 UserRequest 上添加 `creator_id` 字段（指向 Person 类的外部键）
- 自动存储对象创建者
- 通过查询历史记录更新现有工单

## 添加 creator_id 字段

参考[为 Server 类添加字段](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-attribute-sample)。

若决定在 UserRequest、Incident、Change 等详情中显示 `creator_id`，建议将其设为[只读](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)。

## 自动填充创建者

Ticket 创建时自动使用当前用户的关联人员初始化 `creator_id`：

```php
protected function OnInsert()
{
    $this->Set('creator_id', UserRights::GetContactId());
    parent::OnInsert();
}
```

然后运行 Setup 使新字段生效。

## 数据初始化

### 1. 运行查询

```sql
SELECT co, p FROM CMDBChangeOp AS co
  JOIN CMDBChange AS c ON co.change=c.id
  JOIN Ticket AS t ON co.objkey=t.id
  JOIN USER AS u ON c.user_id=u.id
  JOIN Person AS p ON u.contactid=p.id
WHERE co.finalclass="CMDBChangeOpCreate"
```

### 2. CSV 导入

使用高级模式导入两列：

- `co.object_id` -> Ticket id（主键）
- `p.id`（主键）-> Creator

导入到 UserRequest 和 Incident。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:tracking-creator>

版本：3_2_0/customization/tracking-creator.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
