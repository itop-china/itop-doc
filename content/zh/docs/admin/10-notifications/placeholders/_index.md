---
title: "通知占位符"
linkTitle: "配置：通知占位符"
date: 2025-06-27
weight: 2
description: >
  通知模板中的占位符参考。
---

{{% pageinfo %}}

邮件通知的"主题"和"正文"部分支持占位符：

{{% /pageinfo %}}

## 语法

| 语法 | 在工单通知上的示例 |
|---|---|
| `$this->attribute$` | `$this->ref$` 被替换为工单编号 |
| `$this->external_key->attribute$` | `$this->caller_id->email$` 被替换为工单报告人的邮箱 |
| `$this->representation(attribute)$` | `$this->html(log)$` 被替换为 HTML 格式的公共日志 |
| `$CONSTANT$` | `$APP_URL$` 被替换为 iTop 应用的 URL |
| `$this->function()$` | `$this->hyperlink(portal)$` 被替换为 iTop 门户中工单的 URL |

这 5 种情况详述如下。扩展可以添加其他占位符，例如 Approval... 请查看扩展文档以获取更多详细信息。

## 属性占位符

| 函数 | 描述 | 支持的属性类型 |
|---|---|---|
| `$this->attribute$` | 属性值的纯文本表示 | 任何 |
| `$this->id$` | 当前对象的 id（当时没有这样的属性） | |
| `$current_contact->attribute$` | 执行激活触发器的更改的人员 | |

## 扩展语法

扩展语法提供了一种快速从相关对象检索数据的方法，如下例所示：

- `$this->approver_id->phone$`
- `$this->approver_id->org_id->code$`
- `$this->approver_id->org_id->hyperlink()$`
- `$this->parent_request_id->hyperlink(portal)$`

每个内置函数和属性表示在最后一个 `->` 之后都可用。

## 属性表示

| 函数 | 描述 | 支持的属性类型 |
|---|---|---|
| `$this->html(attribute)$` | 属性值的源 HTML，HTML 标签被转义。仅在邮件正文中使用（HTML 部分），以便美观显示。甚至可以用于可能包含 HTML 标签的文本属性，我们希望按原样保留这些标签。 | 任何 |
| `$this->label(attribute)$` | 属性值的本地化表示。语言是当前登录用户的语言。 | 任何（仅对 AttributeEnum 有意义） |
| `$this->head(log)$` | 案例日志最新条目的纯文本 | AttributeCaseLog |
| `$this->head_html(log)$` | 最新条目的 HTML 格式表示，而 `$this->html(attribute)$` 返回整个案例日志的 HTML 格式表示（您可以应用自己的 CSS 样式使其美观）。 | AttributeCaseLog |
| iTop 2.4 新增：`$this->raw(attribute)$` | 日期（时间）的 SQL 格式表示，而 `$this->(attribute)$` 返回根据配置参数格式化的值。 | AttributeDatetime |

## 固定占位符

| 占位符 | 含义 |
|---|---|
| `$APP_URL$` | iTop 应用的 URL |
| `$MODULES_URL$` | 模块的根 URL（例如 `$APP_URL$/env-production`） |

## 内置函数占位符

| 占位符 | 含义 |
|---|---|
| `$this->name()$` | 当前对象的名称 |
| `$this->hyperlink()$` | 在 iTop 控制台中访问当前对象的超链接 |
| `$this->hyperlink(portal)$` | 在 iTop 门户中访问当前对象的超链接 |
| `$this->hyperlink(itop-portal-view)$` | 在 iTop 门户中以只读模式打开当前对象 |
| `$this->hyperlink(itop-portal-edit)$` | 在 iTop 门户中以修改模式打开当前对象 |
| `$this->url()$` | 在 iTop 控制台中访问当前对象的 URL |

警告：对于自定义门户，您需要创建 URLMaker 类：参见 urlmaker。

## 示例：UserRequest

假设在分配 User Request 时触发通知，消息正文可以是：

```
Dear $this->html(agent_id),
The ticket $this->ref$ has been assigned to you.

More information about this ticket
Title: $this->title$

Description:
$this->description$

Public log:
$this->head_html(public_log)$

Impacted CIs:
$this->html(functionalcis_list)$

Click here to display the details of the ticket: $this->hyperlink()$ (authentication required)
```

## 常见问题

### 故障排除

**问：为什么我的占位符在发送的邮件中没有被真实值替换？**

**答：**

- 您拼写错误了字段代码，或者该代码在触发通知的类上不存在
- 检查通知正文的源代码（CKEditor 提供 <source> 按钮），如果 html 标签在占位符内部，这会破坏匹配机制，文本不会被值替换

**问：我的占位符是否被翻译取决于谁触发事件，为什么？**

**答：**占位符是否被翻译取决于触发通知的用户是否被允许查看对象，该字段的值必须放入通知中。

让我们举一个通过用户门户由报告人触发的通知示例，并假设：

- 门户用户的允许组织仅限于他自己的组织
- 工单代理属于与报告人不同的组织
- 数据模型被修改，在 UserRequest 类上定义了一个新的外部字段 `agent_email`，返回代理（Person）的邮箱字段

在这种情况下：

- `$this->agent_email$` 将被替换为其值，因为门户用户正在请求查看他可以看到的 UserRequest 的 UserRequest 字段
- `$this->agent_id->email$` **不会**被替换，因为门户用户正在请求查看他无法查看的 Person 的 Person 字段
- `$this->html(functionalcis_list)$` 将仅替换为属于他自己组织的 FunctionalCI，这可能少于链接到工单的所有 FunctionalCI

此行为与 iTop 设计相关：

- 当您可以看到对象时，您可以看到其所有字段
- 访问权限按对象控制，当您无法看到对象 A（例如 Organization）时，您看不到它的任何字段
- 例外是当对象 A 的字段（Organization.code）通过外部键（org_id）和外部字段（org_id_code）镜像到另一个对象 B（Person）上时。如果您可以看到对象 B（Person），那么您也可以看到已镜像的对象 A 的字段（示例中的 Organization code）

### 自定义

**问：我可以自动将团队签名添加到 UserRequest 邮件通知中吗？**

**答：**

- 自定义 Team 类，添加一个 `signature` 字段，类型为 AttributeTemplateHTML，如果您想让它好看，例如带有 logo
- 然后在正文末尾添加 `$this->team_id->signature$`

**问：我可以在通知中发送当前对象的 id 吗？**

**答：**虽然没有 'id' 属性，但占位符 `$this->id$` 可用于表示 iTop 内部标识符。

**问：如果我创建了多个门户，我可以发送指向特定门户的超链接吗？**

**答：**您可以通过将 portal 替换为新门户的 id 来指向任何门户。例如 `$this->hyperlink(partner-portal)$`

**问：我可以发送指向门户中转换的超链接吗？例如，关闭工单。**

**答：**您可以在通知中添加超链接：

```
$APP_URL$pages/exec.php/object/apply-stimulus/ev_close/UserRequest/$this->id$?exec_module=itop-portal-base&exec_page=index.php&portal_id=itop-portal
```

- 将 `ev_close` 替换为您要应用的刺激
- 您还可以将 `portal_id=itop-portal` 替换为您自己门户的代码

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:admin:placeholders>

版本：3_2_0/admin/placeholders.txt · Last modified: 2025/10/29 11:52 by 127.0.0.1
