---
title: "为他人创建工单"
linkTitle: "为他人创建工单"
date: 2025-06-27
weight: 10
description: >
  为他人创建工单。
---

{{% pageinfo %}}
本文档介绍如何允许门户中的高级用户（Power User）为组织中的其他人员创建工单。通过修改 `caller_id` 字段的过滤器来实现。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_change_caller)。
{{% /pageinfo %}}

## 概述

**使用场景**：允许高级用户（Power User）在门户中为组织中的其他人员创建工单。

## 前提条件

- 熟悉[教程中使用的语法](../../../)
- 已[创建扩展](../../../)
- 熟悉 [XML 门户逻辑](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)
- 拥有安装了增强版门户的 iTop 系统
- 拥有 "Portal User" 和 "Power User" 角色的账户
- 能够修改数据模型定义（创建扩展或使用 ITSM Designer）

## 实现方法

要限制此功能仅对高级用户可用，需要修改数据模型中 Ticket 类的 `caller_id` 字段的过滤器。过滤器是一个 OQL 查询，根据其他工单字段和/或当前用户定义建议的呼叫者列表。

### XML 门户表单

对于我们的使用场景，只需要修改工单创建表单，并在该表单中重新定义 `twig` 标签。由于 `twig` 下方的 XML 标签没有 id，您必须**始终**重新定义该标签的完整内容。

```xml
<module_design id="itop-portal" _delta="must_exist">
  <forms>
    <form id="ticket-create" _delta="must_exist">
      <twig _delta="redefine">
        <div class="row">
          <div class="col-sm-6">
            <div class="form_field" data-field-id="service_id" data-field-flags="mandatory"></div>
          </div>
          <div class="col-sm-6">
            <div class="form_field" data-field-id="servicesubcategory_id" data-field-flags="mandatory"></div>
          </div>
        </div>
        <div id="service_details_placeholder">
          <div class="form_field" data-field-id="service_details"></div>
        </div>
        <div class="row">
          <div class="col-sm-4">
            <div class="form_field" data-field-id="caller_id"></div>
          </div>
          <div class="col-sm-4">
            <div class="form_field" data-field-id="impact"></div>
          </div>
          <div class="col-sm-4">
            <div class="form_field" data-field-id="urgency"></div>
          </div>
        </div>
        <div>
          <div class="form_field" data-field-id="title"></div>
          <div class="form_field" data-field-id="description"></div>
          <div class="form_field" data-field-id="contacts_list"></div>
        </div>
      </twig>
    </form>
  </forms>
</module_design>
```

### caller_id 过滤器

可以通过在 `Ticket.caller_id` 上设置以下复杂的 `filter` 标签来更改上述限制（需要 iTop 2.7.0 或更高版本）：

```sql
SELECT Person WHERE 
(org_id=:this->org_id 
AND 
  (:current_contact_id NOT IN (SELECT Person AS p 
                           JOIN USER AS u ON u.contactid=p.id
                           JOIN URP_UserProfile AS uup ON uup.userid=u.id 
                           JOIN URP_Profiles AS up ON uup.profileid=up.id 
                           WHERE up.name='Portal user' AND p.id = :current_contact_id
                           ) 
  OR :current_contact_id IN (SELECT Person AS p 
                           JOIN USER AS u ON u.contactid=p.id
                           JOIN URP_UserProfile AS uup ON uup.userid=u.id 
                           JOIN URP_Profiles AS up ON uup.profileid=up.id 
                           WHERE up.name='Portal power user' AND p.id = :current_contact_id
                           )
  )
)
OR (org_id=:this->org_id AND id=:current_contact_id)
```

这个 OQL 查询的逻辑是：

- 如果当前用户**不是**普通 "Portal user"，或者**是** "Portal power user"，则允许选择同一组织中的任何人员
- 否则，只能选择自己

> **注意**：以下更短的查询似乎更简洁，但**不起作用**。根本原因仍在调查中。

```sql
SELECT Person WHERE 
(org_id=:this->org_id 
AND 
  (:current_user->id NOT IN (SELECT USER AS u 
                           JOIN URP_UserProfile AS uup ON uup.userid=u.id 
                           JOIN URP_Profiles AS up ON uup.profileid=up.id 
                           WHERE up.name='Portal user' AND u.id = :current_user->id
                           ) 
  OR :current_user->id IN (SELECT USER AS u 
                           JOIN URP_UserProfile AS uup ON uup.userid=u.id 
                           JOIN URP_Profiles AS up ON uup.profileid=up.id 
                           WHERE up.name='Portal power user' AND u.id = :current_user->id
                           )
  )
)
OR (org_id=:this->org_id AND id=:current_contact_id)
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_change_caller>

Last modified: 2024/09/10 10:25 by127.0.0.1

版本：3_2_0/customization/portal_howto_change_caller.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
