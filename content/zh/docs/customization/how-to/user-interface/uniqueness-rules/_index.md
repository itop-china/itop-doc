---
title: "防止重复"
linkTitle: "防止重复"
date: 2025-06-27
weight: 10
description: >
  通过唯一性规则防止数据重复。
---

{{% pageinfo %}}
本文档介绍如何为 iTop 类定义唯一性规则，防止重复数据。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:uniqueness-rules)。
{{% /pageinfo %}}

## 概述

通过自定义 iTop，可以在类上指定唯一性规则，防止重复条目。本教程涵盖：

- 唯一性规则的用户体验
- 如何定义新的唯一性规则
- iTop 默认在 Person 类上定义的唯一性规则
- 如何移除现有的唯一性规则

**前置条件**：熟悉教程中使用的语法，并已创建扩展。

## 用户体验

- 规则指定必须检查唯一性的对象范围。例如，不希望两个 Person 具有相同的员工编号，除非该编号为空。范围则是所有 `employee_number` 不为空的 Person
- 在控制台或门户的单个创建/修改操作中，规则可以：
  - 阻止对象的创建/更新
  - 或仅在创建/更新后显示警告消息
- 唯一性规则适用于类的一个或多个字段（包括 ExternalFields）
- 不支持 File、Image、Dashboard、Stopwatch 等属性类型的唯一性

## 管理员视角

### 默认规则

| 类 | 规则 ID | 字段 | 行为 |
|----|---------|------|------|
| Brand | name | name | 必须唯一（阻止） |
| Model | name_brand | name + brand_id | 必须唯一（阻止） |
| Person | employee_number | org_id + employee_number | 仅当 employee_id 已定义时必须唯一（阻止） |
| Person | name | org_id + first_name + name | 应该唯一（仅警告） |

### 定义自己的规则

定义唯一性规则只需要编写 XML。

#### 示例：Server 名称唯一

在同一组织内，不允许两个 Server 具有相同名称：

```xml
<uniqueness_rules>
  <rule id="server_name" _delta="define">
    <!-- 必须唯一的 "Server" 字段或字段组合 -->
    <attributes>
      <attribute id="name"/>
      <attribute id="org_id"/>
    </attributes>
  </rule>
</uniqueness_rules>
```

错误消息字典条目：

```xml
<entry id="Class:Server/UniquenessRule:server_name">
  <![CDATA[There is already a server with the same name in the '$this->org_id_friendlyname$' organization]]>
</entry>
```

#### 示例：跨子类唯一

防止两个 FunctionalCI 具有相同名称，但 SoftwareInstance、MiddlewareInstance、DatabaseSchema 和 ApplicationSolution 除外：

```xml
<classes>
  <class id="FunctionalCI" _delta="must_exist">
    <properties>
      <uniqueness_rules>
        <!-- "id" 必须是单个单词，不含特殊字符，下划线除外 -->
        <rule id="functionalci_name" _delta="define">
          <!-- 必须唯一的 "FunctionalCI" 字段或字段组合 -->
          <attributes>
            <attribute id="name"/>
          </attributes>
          <!-- 定义 OQL WHERE 子句，条件基于 FunctionalCI 字段 -->
          <!-- 将被组合为 "SELECT FunctionalCI WHERE " + <filter> -->
          <filter><![CDATA[
             finalclass NOT IN ('DBServer','Middleware',
            'OtherSoftware','WebServer','PCSoftware','MiddlewareInstance',
            'DatabaseSchema','ApplicationSolution')]]>
          </filter>
          <!-- 此标志允许保留规则但禁用 -->
          <disabled>false</disabled>
          <!-- 如果为 true 或省略，重复将阻止创建/更新 -->
          <!-- 否则在创建/更新后显示警告消息 -->
          <is_blocking>true</is_blocking>
        </rule>
      </uniqueness_rules>
    </properties>
  </class>
</classes>
<dictionaries>
  <dictionary id="EN US" _delta="must_exist">
    <entries>
      <entry id="Class:FunctionalCI/UniquenessRule:functionalci_name" _delta="define">
        <![CDATA[There are already a Functional CI with that name, please use another name.]]>
      </entry>
      <entry id="Class:FunctionalCI/UniquenessRule:functionalci_name+" _delta="define">
        <![CDATA[FunctionalCI name should be unique]]>
      </entry>
    </entries>
  </dictionary>
</dictionaries>
```

- 不带 `+` 的条目用于唯一性规则的错误消息
- 带 `+` 的相同代码对应规则的描述，目前尚未在任何地方显示，但未来可能在数据模型查看器中显示

### 默认规则示例：Person

iTop 默认在 Person 类上定义了两个规则：

**employee_number**

- 阻止规则，出错时阻止创建/更新
- 阻止同一组织中的两个 Person 具有相同的员工编号
- 允许空员工编号，不会生成错误，即使同一组织中存在其他空员工编号的 Person
- 两个 Person 只有在属于不同组织时才可以具有相同的非空员工编号

**name**

- 仅警告规则，不阻止创建/更新，仅显示消息
- 当同一组织中存在同名时生成

```xml
<uniqueness_rules>
  <rule id="employee_number">
    <attributes>
      <attribute id="org_id"/>
      <attribute id="employee_number"/>
    </attributes>
    <!-- 允许空员工编号，不会被视为重复 -->
    <filter><![CDATA[employee_number != '']]></filter>
    <disabled>false</disabled>
    <is_blocking>true</is_blocking>
  </rule>
  <rule id="name">
    <attributes>
      <attribute id="org_id"/>
      <attribute id="name"/>
      <attribute id="first_name"/>
    </attributes>
    <filter/>
    <disabled>false</disabled>
    <is_blocking>false</is_blocking>
  </rule>
</uniqueness_rules>
```

## 移除默认规则

要移除默认数据模型中定义的现有唯一性规则，需要知道：

- 规则声明的类（如 "Person"）
- 规则的 `rule_id`（如 `employee_number`）

移除规则需要一段嵌入在扩展中的 XML，关键是上层节点中使用 `_delta="delete"`，将移除该节点及其所有子节点：

```xml
<class id="Person" _delta="must_exist">
  <properties>
    <uniqueness_rules>
      <rule id="employee_number" _delta="delete"/>
    </uniqueness_rules>
  </properties>
</class>
```

## 部分禁用规则

假设 FunctionalCI 上定义了以下规则：

```xml
<uniqueness_rules>
  <rule id="functionalci_name" _delta="define">
    <attributes>
      <attribute id="name"/>
      <attribute id="finalclass"/>
    </attributes>
  </rule>
</uniqueness_rules>
```

现在要为 DatacenterDevice（FunctionalCI 的子类）更改此规则，要求 DatacenterDevice 的所有子类中名称唯一。

为此，禁用父类规则 `functionalci_name`，并定义新规则 `datacenterdevice_name`：

```xml
<uniqueness_rules>
  <!-- 使用与要停止的规则相同的 rule_id -->
  <!-- 在子类上，节点是新的，因此使用 _delta="define" -->
  <rule id="functionalci_name" _delta="define">
    <!-- 覆盖现有规则时，'disabled' 是唯一支持的标签 -->
    <!-- 这将禁用 DatacenterDevice 的 'functionalci_name' 规则 -->
    <disabled>true</disabled>
  </rule>
  <!-- 然后可以添加另一个规则... -->
  <rule id="datacenterdevice_name" _delta="define">
    <attributes>
      <attribute id="name"/>
    </attributes>
  </rule>
</uniqueness_rules>
```

## 参考

- [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:uniqueness-rules)

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:uniqueness-rules>

版本：3_2_0/customization/uniqueness-rules.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
