---
title: "查看更多或更少的工单"
linkTitle: "查看更多或更少的工单"
date: 2025-06-27
weight: 10
description: >
  查看更多或更少的工单。
---

{{% pageinfo %}}
本文档介绍如何修改用户门户中可见的工单列表。通过修改 Ticket 的 Scope（范围），可以控制用户能看到哪些工单。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_change_scope)。
{{% /pageinfo %}}

## 概述

**使用场景**：允许用户不仅查看自己作为呼叫者的工单，还能查看自己被添加为联系人的工单。

## 前提条件

- 熟悉[教程中使用的语法](../../../)
- 已[创建扩展](../../../)
- 熟悉 [XML 门户逻辑](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)
- 拥有安装了增强版门户的 iTop 系统
- 拥有 "Portal User" 角色的账户
- 能够修改数据模型定义（创建扩展或使用 ITSM Designer）

## XML 门户逻辑

对于我们的使用场景，只需要修改 Ticket 的 **Scopes（范围）**。范围定义了对于给定类，具有或不具有特定角色的用户可以查看或修改的对象。

## 现有工单范围

默认的工单范围是：

- **all**：普通 "Portal user" 只能查看自己作为"呼叫者"的工单
- **portal-power-user**："Power Portal user" 可以查看其组织中的所有工单

```xml
<module_design id="itop-portal">
  <classes>
    <class id="Ticket">
      <scopes>
        <scope id="all">
          <oql_view><![CDATA[
            SELECT Ticket AS T WHERE T.caller_id = :current_contact_id 
            AND T.finalclass IN ('UserRequest', 'Incident')]]>
          </oql_view>
          <!-- oql_edit 与 oql_read 组合 -->
          <!-- 您永远不能修改无法查看的内容 -->
          <!-- 以下查询对读取没有进一步限制 -->
          <oql_edit><![CDATA[SELECT Ticket AS T]]></oql_edit>
          <!-- 没有 allowed_profiles 标签，因此此范围适用于所有用户 -->
        </scope>
        <scope id="portal-power-user">
          <oql_view><![CDATA[
            SELECT Ticket AS T WHERE T.org_id = :current_contact->org_id 
            AND T.finalclass IN ('UserRequest', 'Incident')]]>
          </oql_view>
          <oql_edit><![CDATA[SELECT Ticket AS T]]></oql_edit>
          <!-- 此范围仅适用于具有特定角色的用户 -->
          <allowed_profiles>
            <allowed_profile id="Portal power user"/>
          </allowed_profiles>
        </scope>
      </scopes>
```

## 修改范围

### 添加新范围

以下是一个新的 Ticket 范围，允许"任何门户用户查看他们被链接为联系人的工单"：

```xml
<classes>
  <class id="Ticket" _delta="must_exist">
    <scopes>
      <scope id="all-in-contacts" _delta="define">
        <oql_view><![CDATA[
          SELECT Ticket AS T 
          JOIN lnkContactToTicket AS l ON l.ticket_id = T.id 
          WHERE l.contact_id = :current_contact_id 
          AND T.finalclass IN ('UserRequest', 'Incident')]]>
        </oql_view>
        <!-- 没有 oql_edit 标签意味着此范围不提供写入权限 -->
      </scope>
    </...>
```

此新范围的特点：

- 适用于所有用户
- **不提供**对被链接为联系人但非呼叫者的工单的写入权限

### 修改现有范围

也可以使用以下方法：

```xml
<classes>
  <class id="Ticket" >
    <scopes>
      <scope id="all" _delta="must_exist">
        <oql_view _delta="redefine"><![CDATA[
          SELECT Ticket AS T 
          JOIN lnkContactToTicket AS l ON l.ticket_id = T.id 
          WHERE l.contact_id = :current_contact_id 
          AND T.finalclass IN ('UserRequest', 'Incident')
        UNION 
          SELECT Ticket AS T WHERE T.caller_id = :current_contact_id 
          AND T.finalclass IN ('UserRequest', 'Incident')]]>
        </oql_view>
      </scope>
    </...>
```

修改后的特点：

- 仍然适用于所有用户
- **提供**对被链接为联系人或呼叫者的工单的写入权限
- 但无法单独限制对被链接为联系人但非呼叫者的工单的编辑

## 其他使用场景

### 限制为团队管理的工单

类似的使用场景是将 "Power Portal user" 的工单可见性限制为**由其团队管理**的工单：

```sql
SELECT Ticket AS T 
  JOIN Team AS G ON T.team_id = G.id 
  JOIN lnkPersonToTeam AS l ON l.team_id = G.id 
WHERE T.org_id = :current_contact->org_id 
  AND T.finalclass IN ('UserRequest', 'Incident') 
  AND l.person_id = :current_contact->id
```

### 扩展到子组织的工单

另一个使用场景是将 "Power Portal user" 的工单可见性扩展到**其子组织**的工单：

```sql
SELECT Ticket AS T 
  JOIN Organization AS root ON T.org_id = root.id 
  JOIN Organization AS child ON child.parent_id BELOW root.id 
WHERE T.org_id = :current_contact->org_id 
  AND T.finalclass IN ('UserRequest', 'Incident') 
```

### 限制为允许的组织（不级联）

如何防止具有允许组织的门户用户查看其允许组织的子组织的工单：

- 默认情况下，iTop 会级联用户允许组织的子组织的访问权限。在 3.1.0 中，没有直接方法阻止此行为。
- 以下 OQL 范围是门户用户严格限制在其允许组织的变通方法。
- **注意**：这样做将阻止没有允许组织的门户用户查看任何工单

```sql
SELECT Ticket AS T
  JOIN Organization AS O ON T.org_id=O.id
  JOIN URP_UserOrg AS AO ON AO.allowed_org_id=O.id
  JOIN USER AS U ON AO.userid = U.id
WHERE U.contactid = :current_contact_id
  AND T.finalclass IN ('UserRequest', 'Incident')
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_change_scope>

版本：3_2_0/customization/portal_howto_change_scope.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
