---
title: "将工单传输到另一个 iTop"
linkTitle: "将工单传输到另一个 iTop"
date: 2025-06-27
weight: 10
description: >
  将工单传输到另一个 iTop。
---

{{% pageinfo %}}
本文档介绍如何使用 Webhook 和 REST Web 服务将工单从一个 iTop 实例传输到另一个 iTop 实例（如合作伙伴）。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:itop-webhook)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 场景

将您的 iTop 与合作伙伴的 iTop 实例互联，当特定工单需要由他们在其 iTop 中处理时，实现以下场景：

1. **识别需要传输的工单**：支持代理识别需要提交给使用 iTop 的合作伙伴的工单，将工单移至特定状态并选择适当的合作伙伴
2. **传输工单**：工单进入特定状态时，触发 iTop Webhook 调用，在合作伙伴 iTop 中创建复制工单
3. **推送更多详情**：当您的私有日志更新时，推送到合作伙伴工单
4. **获取合作伙伴反馈**：当合作伙伴工单公共日志更新时，镜像到您的私有日志
5. **工单解决**：合作伙伴工单解决时，重新分配您的工单，并将合作伙伴解决方案复制到您的私有日志

## 识别需要传输的工单

需要在 `UserRequest` 上添加 `partner_id` 外键字段，以选择应处理问题的合作伙伴：

```xml
<field id="partner_id" xsi:type="AttributeExternalKey" _delta="define">
  <sql>partner_id</sql>
  <filter>SELECT Organization WHERE category='partner'</filter>
  <dependencies/>
  <is_null_allowed>true</is_null_allowed>
  <target_class>Organization</target_class>
  <on_target_delete>DEL_AUTO</on_target_delete>
  <tracking_level>all</tracking_level>
</field>
```

修改 `UserRequest` 生命周期：

- 创建新状态 "Pending partner"（代码 `pending_partner`）
- 创建 `ev_pendingpartner` 刺激和从 "Assigned" 到 "Pending partner" 的转换，该转换必须提示必填的 `partner_id`
- 创建 `ev_partnerupdate` 刺激和从 "Pending partner" 回到 "Assigned" 的转换，由合作伙伴使用 REST 服务触发

## 传输工单

为便于更新对方 iTop 工单，最简单的方式是在 `UserRequest` 上存储远程 ID。双方 iTop 都需要添加 `remote_ticketid` 字段：

```xml
<field id="remote_ticketid" xsi:type="AttributeInteger" _delta="define">
  <sql>remote_ticketid</sql>
  <default_value>0</default_value>
  <is_null_allowed>false</is_null_allowed>
  <tracking_level>all</tracking_level>
</field>
```

### 触发器

在您的 iTop 上创建**触发器（进入状态时）**："Pending partner"，过滤器：

```
SELECT UserRequest WHERE remote_ticketid = 0
```

### iTop Webhook 调用

创建 iTop Webhook 调用，链接到上述触发器，在合作伙伴 iTop 上复制工单。

#### 远程 iTop 连接

合作伙伴需要提供一个具有 REST 访问权限的 iTop 用户，权限可限制为特定组织和角色。访问权限必须包括：

- 至少读取 Organization、Contact 和 Ticket
- 对用户请求的写入权限

#### JSON 数据

提供在合作伙伴 iTop 上创建用户请求的 JSON 数据：

```json
{
  "operation":"core/create",
  "comment":"Ticket transfer by Combodo",
  "class":"UserRequest",
  "output_fields":"id, friendlyname",
  "fields":
  {
    "org_id":"SELECT Organization WHERE name = 'Combodo'",
    "caller_id":{"name":"Combodo","first_name":"Support"},
    "title":"$this->title$",
    "description":"$this->description$",
    "public_log":"$this->private_log$",
    "remote_ticketid":"$this->id$"
  }
}
```

#### 处理响应回调

创建 `SetExternalID` 方法处理响应，存储远程工单 ID：

```php
public function SetExternalID($oResponse,$oAction)
{
   $sBodyAsJSON = $oResponse->GetBody(); 
   $aBody = json_decode($sBodyAsJSON, true); 

   if (false === $aBody) {
      throw new Exception('Could not process response as it is not a valid JSON string: '.$sBodyAsJSON);
   }
   if (false === isset($aBody['objects'][0]['key'])) { 
      throw new Exception('Could not retrieve external ID') ;
   }
   $sExternalID = $aBody['objects'][0]['key'];
   $this->Set('remote_ticketid', $sExternalID);
   $this->DBUpdate();
}
```

## 推送更多详情

当请求者或代理向工单添加信息时，自动镜像到合作伙伴工单。

### 触发器

在您的 iTop 上创建**触发器（对象更新时）**，当公共和私有日志字段修改时触发。

### iTop Webhook 调用

创建另一个 iTop Webhook 调用，链接到上述触发器，更新合作伙伴 iTop 上的工单。

#### JSON 数据

```json
{
  "operation":"core/update",
  "comment":"Ticket update by Combodo",
  "class":"UserRequest",
  "key":"$this->remote_ticketid$",
  "output_fields":"id, friendlyname",
  "fields":
  {
    "public_log":"$this->head(private_log)$"
  }
}
```

## 获取合作伙伴反馈

合作伙伴更新其公共日志时，将回复镜像到您的私有日志。

您需要向合作伙伴提供一个具有 REST 访问权限的 iTop 用户，允许读取和更新已传输的用户请求。

合作伙伴需要在其 iTop 上创建：

- 连接到您 iTop 的**远程 iTop 连接**
- **触发器（对象更新时）**和链接的 **iTop Webhook 调用**

JSON 数据注意公共和私有日志的反转：

```json
{
  "operation":"core/update",
  "comment":"Ticket update by Partner",
  "class":"UserRequest",
  "key":"$this->remote_ticketid$",
  "output_fields":"id, friendlyname",
  "fields":
  {
    "private_log":"$this->head(public_log)$"
  }
}
```

## 工单解决

合作伙伴解决其工单时，您的工单应重新分配给代理，并附带评论。

### 在合作伙伴 iTop 上

- 创建**触发器（进入状态时）**："Resolved"，过滤器 `SELECT UserRequest WHERE remote_ticketid > 0`
- 创建 iTop Webhook 调用，应用 `ev_partnerupdate` 刺激并更新您的私有日志

```json
{
  "operation":"apply_stimulus",
  "comment":"Ticket update by Combodo",
  "class":"UserRequest",
  "key":"$this->remote_ticketid$",
  "stimulus": "ev_partnerupdate",
  "output_fields":"id, friendlyname",
  "fields":
  {
    "private_log":"$this->solution$"
  }
}
```

### 在您的 iTop 上

- 添加**触发器（进入状态时）**："Assigned"，过滤器 `SELECT UserRequest WHERE STATUS = 'pending_partner'`

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:itop-webhook>

2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/itop-webhook.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
