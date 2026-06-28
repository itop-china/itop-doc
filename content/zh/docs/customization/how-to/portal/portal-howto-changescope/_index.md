---
title: "修改范围"
linkTitle: "修改范围"
date: 2025-06-27
weight: 10
description: >
  修改范围。
---

{{% pageinfo %}}
本文档介绍如何更改门户中的可见范围（Scope）。包括修改服务目录的默认显示模式、允许支持代理在门户中处理工单等场景。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_changescope)。
{{% /pageinfo %}}

## 概述

本教程介绍如何更改门户中的可见范围，涵盖多个常见使用场景。

## 修改服务目录的默认显示模式

**问题**：如何更改服务目录的默认显示模式？

```xml
<module_design id="itop-portal" _delta="must_exist">
  <bricks>
    <brick id="services" xsi:type="Combodo\iTop\Portal\Brick\BrowseBrick" _delta="must_exist">
      <browse_modes>
        <default _delta="redefine">mosaic</default>
      </browse_modes>
    </brick>
  </bricks>
</module_design>
```

## 允许支持代理在门户中处理工单

**使用场景**：您有一个主提供商组织，提供多个服务，多个组织购买这些服务。其中一些客户拥有团队和支持代理，他们为主组织的服务交付模型做出贡献，但仅限于作为客户为其组织创建的工单。我们不希望这些代理查看其他客户，也不希望查看主组织的所有工单。

如果他们仅使用控制台，则无法为其组织创建工单，因为他们看不到服务。如果他们使用门户，则需要修改门户，以便他们能够看到交付模型团队和代理，从而能够在组织外分配和分派工单。

### 允许创建处于新建状态的工单

首先，允许支持代理创建处于新建状态的工单，而无需强制直接分派或分配：

```xml
<module_design id="itop-portal" _delta="must_exist">
  <forms>
    <form id="ticket-create" _delta="must_exist">
      <properties _delta="define_if_not_exists">
        <always_show_submit _delta="force">true</always_show_submit>
      </properties>
    </form>
  </forms>
  <classes>
    <class id="Contact" _delta="must_exist">
      <scopes>
        <scope id="agents" _delta="define">
          <oql_view><![CDATA[SELECT Contact ... ]]></oql_view>
          <ignore_silos _delta="force">true</ignore_silos>
          <allowed_profiles>
            <allowed_profile id="Support Agent"/>
          </allowed_profiles>
        </scope>
      </scopes>
    </class>
  </classes>
</module_design>
```

### 查询支持代理可见的联系人

以下查询使支持代理能够看到分派和分配工单所需的团队和相关人员（当他们**不全部**属于用户组织时）。如果都在同一组织中，则此范围无用，标准配置即可：

```sql
SELECT Contact AS c 
  JOIN lnkPersonToTeam AS l2 ON l2.person_id = c.id
  JOIN Team AS t ON l2.team_id=t.id 
  JOIN lnkDeliveryModelToContact AS l1 ON l1.contact_id=t.id 
  JOIN DeliveryModel AS dm ON l1.deliverymodel_id=dm.id 
  JOIN Organization AS o ON o.deliverymodel_id=dm.id 
  WHERE o.id = :current_contact->org_id 
UNION SELECT Contact AS c 
  JOIN lnkDeliveryModelToContact AS l1 ON l1.contact_id=c.id 
  JOIN DeliveryModel AS dm ON l1.deliverymodel_id=dm.id 
  JOIN Organization AS o ON o.deliverymodel_id=dm.id 
  WHERE o.id = :current_contact->org_id
```

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
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_changescope>

版本：3_2_0/customization/portal_howto_changescope.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
