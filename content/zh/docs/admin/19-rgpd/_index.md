---
title: "管理个人数据"
linkTitle: "技巧：管理个人数据"
date: 2025-06-27
weight: 46
description: >
  GDPR 合规提示：如何管理 iTop 中的个人数据。
---

{{% pageinfo %}}

如果您必须遵守 GDPR，以下是一些帮助您的提示...

{{% /pageinfo %}}

## iTop 中的个人数据清单

### Person 对象中的个人数据

iTop 中的大部分个人信息存储在 Person 对象中。在标准 iTop 数据模型中，这些数据包括：

| 字段代码 | 标签 | 字段描述 |
|---|---|---|
| email | Email | 人员的电子邮件地址 |
| employee_number | Employee number | 员工编号或公司内使用的任何标识符 |
| first_name | First Name | 人员的名字 |
| function | Function | 人员的职能/职位 |
| location_id | Location | 人员的位置（链接到 Location 对象） |
| manager_id | Manager | 人员的经理（链接到 Person 对象） |
| mobile_phone | Mobile Phone | 手机号码 |
| phone | Phone | 固定电话号码 |
| picture | Picture | 人员的照片 |

由于 iTop 的关系性质，Person 对象中存储的信息不应在其他地方重复。此原则的少数例外如下：

### 历史记录中的个人数据

对 Person 对象的所有修改都记录在该 Person 对象的历史记录中，从而存储了一些个人信息。您可以使用以下 OQL 查询列出对给定 Person 对象所做的所有更改：

```sql
SELECT CMDBChangeOp WHERE objclass='Person' AND objkey=:person_id
```

其中：`person_id` 是 Person 对象的标识符。用户账号关联的联系人所做的所有修改也会记录联系人的名称（即 friendlyname）。

```sql
SELECT CMDBChange WHERE userinfo=:person_name
```

其中：`person_name` 是 Person 的完整名称（即 friendlyname），例如 "Claude Monet"。

### 案例日志中的个人数据

iTop 中的每个案例日志字段存储有关创建每个条目的人员的信息（在当前版本的 iTop 中，无法修改案例日志条目）。案例日志中记录的信息（每个条目）包含：

- 修改的日期和时间
- 进行修改的人员的全名（修改时）
- 进行修改的人员对象的标识符

例如，如果与 Person "Claude Monet"（id=3）关联的用户创建了两个案例日志条目，案例日志的内容将按如下方式存储在数据库中：

```
========== 2018-05-09 11:38:45 : Claude Monet (3) ============
<p>This is the second entry of the case log</p>
========== 2018-05-09 11:38:27 : Claude Monet (3) ============
<p>This is the first entry of the case log</p>
```

### 邮件通知中的个人数据

每当 iTop 以电子邮件形式发送通知时，信息都会记录在 `EventNotificationEmail` 对象中。此对象记录发送到邮件服务器的电子邮件。此对象包含收件人（在 TO、CC 或 BCC 中）的电子邮件地址和发送的消息内容。EmailNotification 对象还存储发送日期。

## 数据流

处理个人数据时的一个重要主题是记录组织内个人数据的流。本文档（和 iTop 本身）无法为您记录此流，因为每个用例都是特定的，取决于在操作 iTop 时建立的流程和集成。但是，iTop 提供了一些功能，可以帮助您记录和控制此信息流。

### REST/JSON Web 服务日志

您可以通过在 iTop 配置文件中将配置参数 `log_rest_service` 设置为 true 来审计通过 REST/JSON 服务执行的操作。设置此参数后，每次 REST/JSON 操作都将在 iTop 数据库中创建一个 EventRestService 对象。此对象记录：

- 操作的日期/时间
- 用于执行操作的用户账号
- JSON 输入参数
- 操作的输出（代码、消息和 JSON 输出的截断版本）

使用所有这些信息，您可以确定通过 REST/JSON Web 服务的个人信息流（如果有）。

### 同步数据源列表

您可以轻松列出所有导入或更新 Person 的同步数据源，通过搜索"目标类"为"Person"的同步数据源。此搜索可以通过"管理工具 / 同步数据源"执行，或运行以下 OQL 查询：

```sql
SELECT SynchroDataSource WHERE scope_class='Person'
```

每个数据源都保留其操作的完整日志，包括运行日期/时间和每次运行的执行操作摘要（创建/更新/删除）。

注意：如果为同步数据源指定了"用户"，则只有指定的用户账号才能执行此同步。

### 批量导出（和批量导入）的限制

- 只有具有对 Person 的"批量读取"能力的用户账号才能执行人员列表的导出。
- 类似地，只有具有对 Person 的"批量修改"能力的用户账号才能执行 Person 的 CSV 导入。
- 这些能力可以在每个用户账号的详情中的"授权矩阵"选项卡中查看。

## 清理个人数据

要完全清理与人员相关的数据，必须：

- 删除与此人员对应的 Person 对象，这也将删除有关此 Person 的历史信息。
- 删除此人员创建的案例日志条目
- 删除发送给此人员的 EmailNotification 对象

但这些操作存在限制：

- 根据目标 Person 对象与 iTop 数据库中其他对象之间的关系，删除 Person 对象可能不可能，除非在某些其他对象上指定替代 Person，以遵守数据库完整性约束。
- 删除案例日志条目目前在 iTop 中未实现，并且由于案例日志文本必须与另一个称为案例日志索引的字段保持一致，因此使用 SQL 查询实现非平凡。
- 更新 CMDBChange 对象以替换对联系人名称的引用可以通过单个 SQL 查询完成，因为只有一个字段 'userinfo' 需要匿名化。由于此字段仅向最终用户显示，而不用于 iTop 中的任何引用，因此没有完整性约束，可以在字段中放入任何值。
- 由于一封邮件通知可能发送给多个人员（在 TO、CC 和 BCC 中），删除一封此类通知将影响除目标人员之外的其他用户。

由于上述限制，"假名化"方法似乎比完全擦除个人数据更现实。

## 个人数据的假名化

这就是 Personal data anonymizer 扩展为您提出的方案。

- 通过在所有必填字段中替换为匿名值（常量或随机）来匿名化 Person 对象
- 清空所有非必填字段（如 Location、Manager、Phone number、n:n 关系）
- 对案例日志条目进行假名化，删除所有对人员的引用，而不更改文本长度，以保留与案例日志"索引"字段的一致性
- 删除 Person 的历史记录（CMDBChange / CMDBChangeOp）以删除字段的"先前值"，这些值将有助于恢复值
- 匿名化包含 Person 名称的 CMDBChange "userinfo" 字段
- 删除超过（短）保留期（3 个月？）的所有 EmailNotification 对象

## 导出个人数据

- 可以使用 iTop 的标准导出功能导出 Person 详情。
- 可以通过搜索每个包含案例日志的对象类（即每个工单类）并搜索"公共日志"包含"联系人名称"来导出案例日志条目。

这可以使用"运行查询"菜单和如下 OQL 实现：

```sql
SELECT UserRequest WHERE (public_log LIKE :name OR private_log LIKE :name)
```

将 `:name` 参数的值指定为 `%contact_friendlyname%`。

例如，要导出 Claude Monet 在案例日志中创建条目的所有 User Request，OQL 查询将是：

```sql
SELECT UserRequest WHERE (public_log LIKE '%Claude Monet%' OR private_log LIKE '%Claude Monet%')
```

可以使用以下 OQL 查询列出和导出通知邮件：

```sql
SELECT EventNotificationEmail WHERE 
      TO = 'email_address' 
   OR cc LIKE '%email_address%' 
   OR bcc LIKE '%email_address%'
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:rgpd>

版本：3_2_0/admin/rgpd.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
