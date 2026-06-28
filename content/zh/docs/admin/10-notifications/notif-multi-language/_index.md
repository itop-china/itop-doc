---
title: "多语言通知"
linkTitle: "配置：多语言通知"
date: 2025-06-26
weight: 24
description: >
  <br> ➡️ 以接收者语言发送通知
---

{{% pageinfo %}}

如何配置 User Request 通知，以便以被通知人员的语言发送？

{{% /pageinfo %}}

## 人员的语言

开箱即用，iTop 不会将任何语言与 Person 关联，因此您需要修改数据模型以在 Person 类上添加一个 `language` 字段。语言与用户关联，但不是每个 Person 都链接到用户。

### 每种语言一个通知

您需要创建与您拥有的语言数量一样多的通知。

- 通知标题和正文将用该语言编写
- 自 iTop 3.1.0 起，通知的语言字段将设置为相同的语言
- 检索要通知的人员的查询，丰富您的 OQL 以按语言过滤，因此在英语通知中，仅在 TO、CC 和 BCC 查询中返回讲英语的人员；在西班牙语通知中，执行相同的逻辑

### 所有语言使用相同的触发器

- 在触发器中，附加各种语言的不同邮件通知。

此解决方案的缺点是每次都会生成 2、3 个或更多通知，其中大多数是空的。

## UserRequest 语言

您可以想象其他检索语言的逻辑：

- 直接为每个 User Request 关联一种语言
- 为每个组织关联一种语言，然后在 UserRequest 上定义一个 AttributeExternalField，使用客户的语言

### 每种语言一个通知

如上所述...

### 每种语言一个触发器

在这种情况下，您应该为每种语言创建一个触发器，按语言过滤 UserRequest，并将每个触发器关联到其语言的单个通知。

此解决方案没有第一个解决方案的缺点。

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:notif-multi-language>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/admin/notif-multi-language.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
