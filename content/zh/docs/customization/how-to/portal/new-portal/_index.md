---
title: "创建新门户"
linkTitle: "创建新门户"
date: 2025-06-27
weight: 10
description: >
  创建新门户。
---

{{% pageinfo %}}
本文档介绍如何从零开始创建一个全新的 iTop 门户实例。需要掌握 XML 配置、类范围（Scope）、表单定义、Brick 配置和 UrlMaker 注册等知识。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:new_portal)。
{{% /pageinfo %}}

## 概述

本教程介绍如何从零开始创建一个全新的门户。您仍然需要参考[门户 XML 参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)，因为它提供了所有定制可能性，而本教程仅涵盖部分内容。如果下面的教程过于详细，可以先阅读[门户定制概述](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_overview)。

## 前提条件

- 熟悉[教程中使用的语法](../../../)
- 已[创建扩展](../../../)

## 门户声明

首先需要在 XML 中声明门户：

- 指定哪些用户可以访问，哪些不能。不是直接指定用户，而是指定**角色（Profile）**。
- 注意：控制台本身也是一个门户，具有特定的 ID（`id=backoffice`），在允许或拒绝角色方面的工作方式相同。

### 默认声明

以下是 iTop 默认的声明方式：

```xml
<portals>
  <portal id="itop-portal"> <!-- 用户门户 -->
    <...>
    <allow/> <!-- 未指定角色，表示允许所有角色 -->
    <deny/>  <!-- 无限制，这就是为什么普通控制台用户也能访问 -->
  </portal>
  <portal id="backoffice">  <!-- 控制台 -->
    <...>
    <allow/> <!-- 允许或拒绝可以组合使用，但组合使用可能会很奇怪 -->
    <deny>   <!-- 拥有以下角色的用户将被拒绝 -->
      <profile id="Portal user"/>
    </deny>  <!-- deny 优先于 allow -->
  </portal>
</portals>
```

### 示例需求

假设我们要创建一个新门户，同时保留标准用户门户（`id=itop-portal`）和控制台。

当拥有超过 2 个门户时，定义角色会变得复杂。需要想象所有情况，但允许和拒绝角色的组合可能会导致死锁。

新门户必须限制为仅拥有新创建的角色"Extension Publisher"的用户访问。这些用户**不能**访问控制台，可能可以也可能不可以访问标准 `itop-portal`，取决于他们是否拥有 "Portal user" 角色。

公司用户没有 "Portal user" 角色，否则他们将无法访问控制台。但我们仍然允许他们访问新门户。为此，我们将创建一个新角色 "XX employee"（XX 为公司名称）。

### 可能的声明方式

以下是声明 3 个门户以实现上述需求的一种方式：

```xml
<portals>
  <portal id="backoffice" _delta="must_exist">
    <deny _delta="redefine">
      <profile id="Portal user"/>
      <profile id="Extension Publisher"/>
    </deny>
  </portal>
  <portal id="itop-portal" _delta="must_exist">
    <allow _delta="redefine">
      <profile id="Portal user"/>
      <profile id="XX employee"/>
    </allow>
  </portal>
  <portal id="extension-publisher-portal" _delta="define">
    <url>pages/exec.php?exec_module=itop-portal-base&amp;exec_page=index.php&amp;portal_id=extension-publisher-portal</url>
    <rank>1.0</rank>
    <handler/>
    <allow>
      <profile id="Extension Publisher"/>
      <profile id="XX employee"/>
    </allow>
    <deny/>
  </portal>
</portals>
```

## 门户设计

需要指定以下内容：

- **classes**：哪些类和对象将在门户中显示
- **forms**：每个类的字段可见性和布局（创建、查看、编辑）
- **bricks**：定义导航菜单和 Brick

## 类 / 范围（Scopes）

范围用于显式指定将在门户中使用的类。除非已为某个类定义了范围，否则该类在门户中**永远不可见**，无论您的角色是什么。即使您是管理员也不足够。

### 用户可见的内容

- 范围定义了在类中，用户可以查看的对象实例。
- 以下示例指定了一个读取范围，适用于**所有**访问门户的用户，不是因为 ID 是 "all"，而是因为未指定 `<allowed_profiles>` 标签，这意味着所有角色都被允许。

```xml
<scope id="all">
  <oql_view><![CDATA[SELECT Ticket WHERE (Condition1) ]]></oql_view>
</scope>
```

- 范围可以通过 `<allowed_profiles>` 标签限制为特定角色的用户。
- 如果多个范围适用于同一用户，则它们将通过 **UNION** 组合。

示例：拥有 "Portal power user" 角色的用户可以看到由范围 "power" 定义的工单，以及范围 "all" 中的工单。

```xml
<scope id="power">
  <oql_view><![CDATA[SELECT Ticket WHERE (Condition2) ]]></oql_view>
  <allowed_profiles>
    <allowed_profile id="Portal power user"/>
  </allowed_profiles>
<scope>
```

最终，用户将看到以下 OQL 返回的任何工单：

```sql
SELECT Ticket WHERE (Condition1) UNION SELECT Ticket WHERE (Condition2)
```

### 用户可修改的内容

- 范围还可以定义用户可以修改的对象。用户永远不允许修改他无法查看的对象，因此在指定可修改内容时，只需指定额外的限制（如果需要）。
- 例如，如果用户应该被允许修改他能看到的任何工单：

```xml
<scope id="all">
  <oql_edit><![CDATA[SELECT Ticket]]></oql_edit>
</scope>
```

这将允许用户修改所有他能看到的工单，无论 `<oql_view>` 查询如何。

### 忽略组织限制

- 门户用户可能通过其 iTop 用户的 "Allowed organizations" 设置被限制在自己的组织内。这是相当常见的，特别是对于服务提供商。
- 然而，在用户级别定义的组织限制可以被门户范围覆盖。**这不是自动的，范围必须显式声明忽略用户的允许组织。** 这仅适用于该范围。
- 标准"用户门户"中有一个示例，使用户能够看到服务目录，即使这些服务不属于用户的组织：

```xml
<class id="Service">
  <scopes>
    <scope id="all">
      <oql_view>
        <![CDATA[
           SELECT Service AS s JOIN lnkCustomerContractToService AS l1 ON l1.service_id=s.id 
              JOIN CustomerContract AS cc ON l1.customercontract_id=cc.id 
              WHERE cc.org_id = :current_contact->org_id AND s.status != 'obsolete'
        ]]>
      </oql_view>
      <ignore_silos>true</ignore_silos>
    </scope>
  </scopes>
</class>
```

### 重要提示

由于必须在任何门户上激活 UserProfileBrick，以下范围也必须在每个门户上声明：

```xml
<class id="User">
  <scopes>
    <scope id="all">
      <oql_view>
        <![CDATA[SELECT User AS U JOIN Person AS P ON U.contactid=P.id WHERE P.id = :current_contact_id]]>
      </oql_view>
    </scope>
  </scopes>
</class>
```

## 拒绝转换（Transitions）

允许阻止某些角色的用户在门户中执行他们通常被允许但在该门户中不应该执行的转换，而应该在控制台或其他门户中执行。

## 列表显示

此部分允许指定当对象作为另一个类的表单中的 LinkedSet 或 LinkedSetIndirect 属性时，应显示哪些字段。如果未指定，则显示的字段列表将与控制台中的相同。

## 表单（Forms）

表单指定了类对象在门户中的显示方式，包括字段呈现及其标志：只读、可写、必填。

对于给定类，您只能有一个表单来定义如何查看对象。但可以有不同模式的不同表单：

- 一个用于对象创建
- 一个用于修改
- 一个用于查看
- 每个转换一个表单

这些表单可以特定于某个场景或在多个场景中重用。

## Brick

Brick 是门户的功能模块。有关 Brick 配置的详细信息，请参考[门户 XML 参考](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_xml)。

## UrlMaker

UrlMaker 类允许 iTop 构建指向特定 GUI（例如您的新门户）的 URL。如果没有为门户注册 UrlMaker，则多个地方的 URL 将格式错误（例如在通知中）。

需要执行以下操作：

1. 创建 2 个专用的 PHP 类，为该门户生成正确的（查看或编辑）URL
2. 在门户中注册此类
3. 全局注册这些类，以便在通知中生成指向该门户的 URL

PHP 代码示例：

```php
<?php
 
use Combodo\iTop\Portal\UrlMaker\AbstractPortalUrlMaker;
 
require_once APPROOT.'/lib/autoload.php';
 
/**
 * 指向对象"编辑"页面的超链接
 */
class MyPortalEditUrlMaker extends AbstractPortalUrlMaker
{
        const PORTAL_ID = 'my-portal';
}
 
/**
 * 指向对象"查看"页面的超链接
 */
class MyPortalViewUrlMaker extends MyPortalEditUrlMaker
{
        /**
         * @inheritDoc
         */
        public static function MakeObjectURL($sClass, $iId)
        {
                return static::PrepareObjectURL($sClass, $iId, 'view');
        }
}
 
// 默认门户超链接（用于通知）是查看超链接
DBObject::RegisterURLMakerClass('my-portal', MyPortalViewUrlMaker::class);
```

在门户 XML 定义中：

```xml
<module_design id="my-portal" _delta="define">
  <properties>
    <urlmaker_class>MyPortalViewUrlMaker</urlmaker_class>
    <!-- ... -->
  </properties>
  <!-- ... -->
</module_design>
```

## 完整 XML 示例

以下是一个完整的门户 XML 配置示例，展示了如何定义类、范围、表单、Brick、操作规则和导航规则：

```xml
<module_design id="my-portal" _delta="define">
  <properties>
    <name>Developers portal</name>
    <urlmaker_class>MyPortalViewUrlMaker</urlmaker_class>
    <triggers_query>
      <![CDATA[SELECT TriggerOnPortalUpdate AS t WHERE t.target_class IN (:parent_classes)]]>
    </triggers_query>
  </properties>
  <classes>
    <class id="User">
      <scopes>
        <scope id="all">
          <oql_view>
            <![CDATA[SELECT User AS U JOIN Person AS P ON U.contactid=P.id WHERE P.id = :current_contact_id]]>
          </oql_view>
        </scope>
      </scopes>
    </class>
    <class id="Organization" _delta="define">
      <scopes>
        <scope id="all">
          <oql_view><![CDATA[SELECT Organization WHERE id = :current_contact->org_id]]></oql_view>
        </scope>
      </scopes>
    </class>
  </classes>
  <!-- 更多配置... -->
</module_design>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:new_portal>

版本：3_2_0/customization/new_portal.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
