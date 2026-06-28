---
title: "SPOC 与合作伙伴"
linkTitle: "SPOC 与合作伙伴"
date: 2025-06-27
weight: 10
description: >
  SPOC 与合作伙伴。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 中为中介公司（合作伙伴）配置工单处理，使其能够代表最终客户在门户中创建和管理工单。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:spoc)。
{{% /pageinfo %}}

## 前提条件

- 熟悉[教程中使用的语法](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 已[创建扩展](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)
- 熟悉 [XML 门户逻辑](https://www.itophub.io/wiki/page?id=3_2_0:customization:start)

## 场景

假设您的公司是 IT 服务提供商，部分最终客户不直接与您联系，而是通过一家中介公司。该中介公司在您的 iTop 门户中代表最终客户进行操作。

- 中介公司代表客户报告特定服务的事件
- 中介公司可能为多个客户扮演该角色
- 最终客户也可以自行报告事件或请求
- 中介公司只能查看他们创建的工单，不能查看其客户的其他工单（可能包含敏感信息）

## 数据模型变更

### 中介的客户

需要为每个中介公司存储其服务的客户，以及为每个客户服务的具体服务。在本教程中，假设给定客户购买的特定服务最多外包给一个中介。

通过在 `lnkCustomerContractToService` 类上添加记录中介公司的外键来实现：

```xml
<class id="lnkCustomerContractToService">
  <fields>
    <field id="managed_by_id" xsi:type="AttributeExternalKey" _delta="define">
      <sql>managed_by_id</sql>
      <target_class>Organization</target_class>
      <filter/>
      <dependencies/>
      <is_null_allowed>true</is_null_allowed>
      <on_target_delete>DEL_MANUAL</on_target_delete>
      <allow_target_creation>false</allow_target_creation>
    </field>
  </fields>
</class>
```

### 工单的请求者

由于中介代表客户创建工单，需要修改 `Ticket` 类上 `caller_id` 的过滤器，使其可以是：

- 客户组织中的任何人
- 或客户组织中管理某服务的中介组织中的任何人

```xml
<class id="Ticket">
  <fields>
    <field id="caller_id" xsi:type="AttributeExternalKey" _delta="must_exist">
      <filter _delta="redefine"><![CDATA[
        SELECT Person WHERE org_id = :this->org_id
        UNION
        SELECT Person AS p 
          JOIN Organization AS i ON p.org_id=i.id 
          JOIN lnkCustomerContractToService AS lnk ON lnk.managed_by_id = i.id
          JOIN CustomerContract AS cc ON lnk.customercontract_id = cc.id
          WHERE cc.org_id = :this->org_id
      ]]></filter>
    </field>
  </fields>
</class>
```

### 建议的服务

可以限制数据模型中仅呈现基于客户和请求者的有效服务：

```xml
<class id="UserRequest">
  <fields>
    <field id="service_id" xsi:type="AttributeExternalKey" _delta="must_exist">
      <filter _delta="redefine"><![CDATA[
        SELECT Service AS s JOIN lnkCustomerContractToService AS l1 ON l1.service_id=s.id 
          JOIN CustomerContract AS cc ON l1.customercontract_id=cc.id
          WHERE cc.org_id = :this->org_id AND s.status != 'obsolete'
          AND l1.managed_by_id = 0
        UNION
        SELECT Service AS s JOIN lnkCustomerContractToService AS l1 ON l1.service_id=s.id 
          JOIN CustomerContract AS cc ON l1.customercontract_id=cc.id
          JOIN Organization AS i ON l1.managed_by_id = i.id
          JOIN Person AS p ON p.org_id = i.id
          WHERE cc.org_id = :this->org_id AND s.status != 'obsolete'
          AND p.id = :this->caller_id
      ]]></filter>
      <dependencies>
        <attribute id="org_id"/>
        <attribute id="caller_id" _delta="define"/>
      </dependencies>
    </field>
  </fields>
</class>
```

## 自定义用户门户

对于中介公司，需要使其能够在创建用户请求之前选择客户。通过为具有特定角色的门户用户创建新的 BrowseBrick 来实现。

- 普通最终用户仍使用 mosaic 视图
- 中介用户使用列表浏览模式查看其各种客户
- 然后中介用户在工单创建表单中选择服务和服务子目录

### 新用户角色

创建一个没有特定访问权限的新角色，命名为 `Portal Multi Contract User`：

```xml
<user_rights>
  <profiles>
    <profile id="912" _delta="define">
      <name>Portal Multi Contract User</name>
      <description>Users with this profile are allowed to create UserRequest on iTop Portal in the name of customers that they serve</description>
      <groups/>
    </profile>
  </profiles>
</user_rights>
```

### 新 BrowseBrick

新的 browseBrick 必须限制为 `Portal Multi Contract User` 角色：

```xml
<brick id="intermediate-customers" xsi:type="Combodo\iTop\Portal\Brick\ManageBrick" _delta="define">
  <active>true</active>
  <width>6</width>
  <rank><default>60</default></rank>
  <title><default>Brick:Portal:IntermediateCustomers:Title</default></title>
  <description>Brick:Portal:IntermediateCustomers:Title+</description>
  <visible>
    <home>false</home>
    <navigation_menu>false</navigation_menu>
  </visible>
  <decoration_class><default>far fa-handshake fc-3x</default></decoration_class>
  <oql><![CDATA[SELECT Organization]]></oql>
  <export><export_default_fields>true</export_default_fields></export>
  <fields>
    <field id="org_id_friendlyname"/>
    <field id="start_date"/>
    <field id="end_date"/>
  </fields>
  <grouping>
    <tabs>
      <groups>
        <group id="all">
          <rank>2</rank>
          <title>Brick:Portal:Licences:Tab:All</title>
          <condition><![CDATA[SELECT Organization]]></condition>
        </group>
      </groups>
    </tabs>
  </grouping>
  <security>
    <allowed_profiles><![CDATA[SELECT URP_Profiles WHERE name = 'Portal Multi Contract User']]></allowed_profiles>
  </security>
</brick>
```

### 移除旧 BrowseBrick 的访问权限

旧 BrowseBrick 必须拒绝新角色访问：

```xml
<brick id="services" xsi:type="Combodo\iTop\Portal\Brick\BrowseBrick" _delta="must_exist">
  <security _delta="define">
    <denied_profiles><![CDATA[SELECT URP_Profiles WHERE name = 'Portal Multi Contract User']]></denied_profiles>
  </security>
</brick>
```

### 重新设计范围

需要重新设计范围：

```xml
<classes>
  <class id="Organization" _delta="must_exist">
    <scopes>
      <scope id="intermediate" _delta="define">
        <oql_view><![CDATA[SELECT Organization AS O WHERE (O.managed_by_id = :current_contact->org_id) OR (O.id = :current_contact->org_id)]]></oql_view>
        <allowed_profiles>
          <allowed_profile id="Portal Multi Contract User"/>
        </allowed_profiles>
      </scope>
    </scopes>
  </class>
  <class id="Contact" _delta="must_exist">
    <scopes>
      <scope id="intermediate" _delta="define">
        <oql_view><![CDATA[SELECT Contact AS C JOIN Organization AS O ON C.org_id = O.id WHERE C.status='active' AND (O.managed_by_id = :current_contact->org_id) OR (O.id = :current_contact->org_id)]]></oql_view>
        <oql_edit><![CDATA[SELECT Contact AS C WHERE C.org_id = :current_contact->org_id]]></oql_edit>
        <allowed_profiles>
          <allowed_profile id="Portal Multi Contract User"/>
        </allowed_profiles>
      </scope>
    </scopes>
  </class>
  <class id="Service" _delta="must_exist">
    <scopes>
      <scope id="intermediate" _delta="define">
        <oql_view><![CDATA[SELECT Service]]></oql_view>
        <allowed_profiles>
          <allowed_profile id="Portal Multi Contract User"/>
        </allowed_profiles>
      </scope>
    </scopes>
  </class>
  <class id="ServiceSubcategory" _delta="must_exist">
    <scopes>
      <scope id="intermediate" _delta="define">
        <oql_view><![CDATA[SELECT ServiceSubcategory]]></oql_view>
        <allowed_profiles>
          <allowed_profile id="Portal Multi Contract User"/>
        </allowed_profiles>
      </scope>
    </scopes>
  </class>
  <class id="UserRequest" _delta="must_exist">
    <scopes>
      <scope id="portal-partner-user" _delta="define">
        <oql_view><![CDATA[SELECT UserRequest AS T JOIN Organization AS O ON T.org_id = O.id WHERE (O.managed_by_id = :current_contact->org_id) OR (O.id=:current_contact->org_id)]]></oql_view>
        <oql_edit><![CDATA[SELECT UserRequest AS T]]></oql_edit>
        <allowed_profiles>
          <allowed_profile id="Portal Multi Contract User"/>
        </allowed_profiles>
      </scope>
      <scope id="in-contact" _delta="define">
        <oql_view><![CDATA[SELECT UserRequest AS T 
          JOIN lnkContactToTicket AS l ON l.ticket_id = T.id 
          WHERE l.contact_id = :current_contact_id ]]></oql_view>
        <oql_edit><![CDATA[SELECT UserRequest AS T]]></oql_edit>
      </scope>
      <scope id="mine" _delta="define">
        <oql_view><![CDATA[SELECT UserRequest AS T 
          WHERE T.agent_id = :current_contact_id  OR T.caller_id = :current_contact_id]]></oql_view>
        <oql_edit><![CDATA[SELECT UserRequest]]></oql_edit>
      </scope>
    </scopes>
  </class>
</classes>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:spoc>

版本：3_2_0/customization/spoc.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
