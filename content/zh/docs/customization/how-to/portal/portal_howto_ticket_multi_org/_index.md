---
title: "门户：为不同客户创建工单"
linkTitle: "门户：为不同客户创建工单"
date: 2025-06-27
weight: 110
description: >
    在 iTop 门户中允许特定用户为其他组织或联系人创建工单。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 门户中允许用户为其他客户创建工单。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_ticket_multi_org)。
{{% /pageinfo %}}

## 目标

在现有的 iTop 门户（`itop-portal` 或任何其他门户）中，我们希望允许某些用户为自己以外的人创建工单。

假设我们有一个或创建一个新的配置文件 `Business partner user`，将其分配给这些用户。

## 范围（Scopes）

这些用户需要能够看到：

- 他们需要为其创建工单的所有组织
- 他们需要为其创建工单的所有联系人
- 他们需要在其上创建工单的所有服务
- 等等

```xml
<class id="Organization">
  <scopes>
    <scope id="portal-partner-user" _delta="define">
      <oql_view><![CDATA[SELECT Organization]]></oql_view>
      <allowed_profiles>
        <allowed_profile id="Business partner user"/>
      </allowed_profiles>
    </scope>
  </scopes>
</class>
<class id="Contact">
  <scopes>
    <scope id="portal-partner-user" _delta="define">
      <oql_view><![CDATA[SELECT Contact]]></oql_view>
      <allowed_profiles>
        <allowed_profile id="Business partner user"/>
      </allowed_profiles>
    </scope>
  </scopes>
</class>
<class id="Service">
  <scopes>
    <scope id="portal-partner-user" _delta="define">
      <oql_view><![CDATA[SELECT Service]]></oql_view>
      <allowed_profiles>
        <allowed_profile id="Business partner user"/>
      </allowed_profiles>
    </scope>
  </scopes>
</class>
<!-- 以及其他类如 ServiceSubcategory、Ticket 等 -->
```

## 砖块（Brick）

这些用户需要能够访问一个新的 BrowseBrick，用于选择客户合同（CustomerContracts）：

```xml
<brick id="new-request-for-partner" xsi:type="Combodo\iTop\Portal\Brick\BrowseBrick" _delta="define">
  <active>true</active>
  <width>6</width>
  <rank>
    <default>11</default>
  </rank>
  <title>
    <default>Brick:Portal:NewRequest:Title</default>
  </title>
  <description>Brick:Portal:NewRequest:Title+</description>
  <decoration_class>
    <default>fc fc-new-request fc-2x</default>
  </decoration_class>
  <levels>
    <level id="1">
      <class>Organization</class>
      <tooltip_att>description</tooltip_att>
      <title>Class:Organization</title>
      <actions>
        <action id="drilldown" xsi:type="drilldown"/>
      </actions>
      <levels>
        <level id="1">
          <oql><![CDATA[SELECT CustomerContract]]></oql>
          <parent_att>org_id</parent_att>
          <name_att>name</name_att>
          <tooltip_att>service_id_friendlyname</tooltip_att>
          <title>Class:CustomerContract</title>
          <actions>
            <action id="create_from_this" xsi:type="create_from_this">
              <class>UserRequest</class>
              <icon_class>fc fc-new-request fc-1-6x fc-flip-horizontal</icon_class>
              <rules>
                <rule id="contact-to-userrequest"/>
                <rule id="contract-to-userrequest"/>
              </rules>
            </action>
            <action id="view" xsi:type="view"/>
          </actions>
          <levels/>
        </level>
      </levels>
    </level>
  </levels>
  <browse_modes>
    <availables>
      <mode id="list"/>
    </availables>
    <default>list</default>
  </browse_modes>
  <security>
    <allowed_profiles><![CDATA[SELECT URP_Profiles WHERE name = 'Business partner user']]></allowed_profiles>
  </security>
  <data_loading>auto</data_loading>
</brick>
```

## 表单（Form）

创建或修改工单创建表单，以允许选择请求人和服务子类别：

```xml
<form id="ticket-create">
  <twig _delta="redefine">
    <div class="row">
      <div class="col-sm-9">
        <div class="row">
          <div class="col-sm-6">
            <div class="form_field" data-field-id="service_id" data-field-flags="mandatory"/>
            <div class="form_field" data-field-id="impact"/>
          </div>
          <div class="col-sm-6">
            <div class="form_field" data-field-id="servicesubcategory_id" data-field-flags="mandatory"/>
            <div class="form_field" data-field-id="urgency"/>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-12">
            <div class="form_field" data-field-id="title"/>
          </div>
        </div>
      </div>
      <div class="col-sm-3">
        <div class="form_field" data-field-id="service_details"/>
      </div>
    </div>
    <div>
      <div class="form_field" data-field-id="description"/>
      <div class="form_field" data-field-id="contacts_list"/>
    </div>
  </twig>
  </properties>
</form>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:portal_howto_ticket_multi_org>

版本：3_2_0/customization/portal_howto_ticket_multi_org.txt · Last modified: 2025/08/12 15:12 by 127.0.0.1
