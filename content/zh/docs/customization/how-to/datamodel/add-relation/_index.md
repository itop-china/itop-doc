---
title: "添加 n:n 关系"
linkTitle: "添加 n:n 关系"
date: 2025-06-27
weight: 10
description: >
  添加 n:n 关系。
---

{{% pageinfo %}}
本文档介绍如何在两个类之间创建多对多（n:n）关系。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-relation)。
{{% /pageinfo %}}

## 概述

本教程演示如何在两个类之间创建多对多关系。以 Person 和 Location 之间的关系为例，记录人员的认证级别和最后访问时间。

iTop 中的多对多关系存储为带有特殊 XML 标签 `<is_link>`（值为 1）的类，告诉 iTop 如何在界面、控制台和门户中处理此类。

## 限制

创建链接类时，以下字段类型**不受支持**：

- Caselog
- LinkedSet、LinkedSetIndirect
- Text、HTML、Template
- File、Image
- Duration
- TagSet、EnumSet

在以下场景中会出现问题：

- **门户中**：编辑包含这些属性的链接将始终失败
- **控制台中编辑宿主对象时**：编辑包含这些属性的链接将始终失败
- **控制台中读取宿主对象时**：弹出窗口中编辑链接支持大多数属性，但 File 和 Image 除外

### 门户 ManageBrick

若在 ManageBrick 中显示 LinkedSetAttribute，将产生错误：

```
DataTables warning: table id=table-UserRequest - Ajax error.
```

## 链接类定义

### 属性

- **class id**：命名约定以 `lnk` 开头，后跟按字母顺序的第一个类名，然后 `To`，最后第二个类名
- **parent**：`cmdbAbstractObject`
- **category**：`bizmodel`
- **db_table**：iTop 约定使用小写的类名
- **naming 和 reconciliation**：通常使用两个相关对象来命名和标识关系

```xml
<class id="lnkLocationToPerson" _delta="define">
  <parent>cmdbAbstractObject</parent>
  <properties>
    <category>bizmodel</category>
    <abstract>false</abstract>
    <db_table>lnklocationtoperson</db_table>
    <is_link>1</is_link>
    <naming>
      <attributes>
        <attribute id="location_id"/>
        <attribute id="person_id"/>
      </attributes>
    </naming>
    <reconciliation>
      <attributes>
        <attribute id="location_id"/>
        <attribute id="person_id"/>
      </attributes>
    </reconciliation>
  </properties>
</class>
```

### 字段

链接类需要两个 `AttributeExternalKey`：`person_id` 和 `location_id`。

```xml
<class id="lnkLocationToPerson" _delta="must_exist">
  <fields _delta="define">
    <field id="location_id" xsi:type="AttributeExternalKey">
      <sql>location_id</sql>
      <filter/>
      <dependencies/>
      <is_null_allowed>false</is_null_allowed>
      <target_class>Location</target_class>
      <on_target_delete>DEL_AUTO</on_target_delete>
    </field>
    <field id="person_id" xsi:type="AttributeExternalKey">
      <sql>person_id</sql>
      <filter/>
      <dependencies/>
      <is_null_allowed>false</is_null_allowed>
      <target_class>Person</target_class>
      <on_target_delete>DEL_AUTO</on_target_delete>
    </field>
    <field id="accreditation" xsi:type="AttributeEnum">
      <sql>accreditation</sql>
      <default_value>restricted</default_value>
      <is_null_allowed>false</is_null_allowed>
      <values>
        <value id="restricted"><code>restricted</code></value>
        <value id="unrestricted"><code>unrestricted</code></value>
      </values>
      <display_style>radio_horizontal</display_style>
    </field>
    <field id="last_visit" xsi:type="AttributeDate">
      <sql>last_visit</sql>
      <is_null_allowed>true</is_null_allowed>
    </field>
  </fields>
</class>
```

### 展示

`details` 和 `list` 为必填，`default_search` 和 `search` 为可选。

```xml
<class id="lnkLocationToPerson">
  <presentation _delta="define">
    <list>
      <items>
        <item id="location_id"><rank>10</rank></item>
        <item id="person_id"><rank>20</rank></item>
        <item id="accreditation"><rank>30</rank></item>
        <item id="last_visit"><rank>40</rank></item>
      </items>
    </list>
    <details>
      <items>
        <item id="col:col1">
          <items>
            <item id="location_id"><rank>10</rank></item>
            <item id="person_id"><rank>20</rank></item>
            <item id="accreditation"><rank>30</rank></item>
            <item id="last_visit"><rank>40</rank></item>
          </items>
          <rank>10</rank>
        </item>
      </items>
    </details>
  </presentation>
</class>
```

### 标签

```xml
<dictionaries>
  <dictionary id="EN US" _delta="must_exist">
    <entries>
      <entry id="Class:lnkLocationToPerson/Name" _delta="define"><![CDATA[%2$s is a visitor of %1$s]]></entry>
      <entry id="Class:lnkLocationToPerson/Attribute:person_id" _delta="define"><![CDATA[Visitor]]></entry>
      <entry id="Class:lnkLocationToPerson/Attribute:location_id" _delta="define"><![CDATA[Location]]></entry>
      <entry id="Class:lnkLocationToPerson/Attribute:accreditation" _delta="define"><![CDATA[Accreditation]]></entry>
      <entry id="Class:lnkLocationToPerson/Attribute:last_visit" _delta="define"><![CDATA[Last visit]]></entry>
    </entries>
  </dictionary>
</dictionaries>
```

### 唯一性规则

若要求在特定 Person 和 Location 之间只能有一个链接：

```xml
<class id="lnkLocationToPerson" _delta="must_exist">
  <properties>
    <uniqueness_rules>
      <rule id="no_duplicate" _delta="define">
        <attributes>
          <attribute id="person_id"/>
          <attribute id="location_id"/>
        </attributes>
        <filter/>
          <disabled>false</disabled>
          <is_blocking>true</is_blocking>
      </rule>
    </uniqueness_rules>
  </properties>
</class>
```

## 远程类引用

### Person 类

在 Person 详情中显示授权位置：

```xml
<fields>
  <field id="locations_list" xsi:type="AttributeLinkedSetIndirect" _delta="define">
    <ext_key_to_remote>location_id</ext_key_to_remote>
    <ext_key_to_me>person_id</ext_key_to_me>
    <linked_class>lnkLocationToPerson</linked_class>
    <count_min>0</count_min>
    <count_max>0</count_max>
    <duplicates>false</duplicates>
  </field>
</fields>
<presentation>
  <details>
    <items>
      <item id="locations_list" _delta="define">
        <rank>200</rank>
      </item>
    </items>
  </details>
</presentation>
```

### Location 类

类似地在 Location 中显示授权访客：

```xml
<field id="persons_list" xsi:type="AttributeLinkedSetIndirect" _delta="define">
  <ext_key_to_remote>person_id</ext_key_to_remote>
  <ext_key_to_me>location_id</ext_key_to_me>
  <linked_class>lnkLocationToPerson</linked_class>
  <count_min>0</count_min>
  <count_max>0</count_max>
  <duplicates>false</duplicates>
</field>
```

### 3.1 特殊显示

iTop 3.1.0+ 可以使用类似 TagSet 和 EnumSet 的 widget 显示多对多关系。将 `display_style` 设置为 `property`（默认值为 `tab`）：

```xml
<field id="locations_list" _delta="must_exist">
  <display_style _delta="force">property</display_style>
</field>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-relation>

2026/06/10 17:31 by127.0.0.1

版本：3_2_0/customization/add-relation.txt · Last modified: 2026/06/10 17:31 by 127.0.0.1
