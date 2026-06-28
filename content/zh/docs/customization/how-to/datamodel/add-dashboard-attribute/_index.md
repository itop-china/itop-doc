---
title: "在 Team 上添加仪表盘"
linkTitle: "在 Team 上添加仪表盘"
date: 2025-06-27
weight: 10
description: >
  在 Team 上添加仪表盘。
---

{{% pageinfo %}}
本文档介绍如何在 Team 对象上添加仪表盘属性，以显示团队相关的信息。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:add-dashboard-attribute)。
{{% /pageinfo %}}

## 概述

在每个 Team 对象上显示一个仪表盘标签页，包含团队相关的信息，例如：

- 分配给该团队的开放工单列表
- 仅限活跃成员的列表
- 至少有一名团队成员所在的位置列表

## 参考 OQL 查询

### 开放工单

```sql
SELECT UserRequest WHERE STATUS IN ('assigned') AND team_id=:this->id
UNION SELECT Incident WHERE STATUS IN ('assigned') AND team_id=:this->id
UNION SELECT Problem WHERE STATUS IN ('assigned') AND team_id=:this->id
```

### 活跃成员

```sql
SELECT Person AS p
   JOIN lnkPersonToTeam AS l ON l.person_id = p.id
   WHERE l.team_id = :this->id AND STATUS='active'
```

### 成员所在位置

```sql
SELECT Location AS L
   JOIN Person AS P ON P.location_id=L.id
   JOIN lnkPersonToTeam AS l1 ON l1.person_id=P.id
   JOIN Team AS T ON l1.team_id=T.id
   WHERE T.id=:this->id
```

## 使用 ITSM Designer（Combodo 客户）

1. 进入 Team 类，Schema 标签页创建新字段
2. 字段代码：`overview`
3. 类型选择：**Dashboard**
4. 设置标签

仪表盘属性可作为对象的额外标签页显示，查询可使用当前对象的上下文。

- 勾选 **Is User Editable** 允许普通用户创建自定义版本
- 管理员始终可以自定义仪表盘

## 使用 iTop 扩展

### 创建仪表盘属性

```xml
<class id="Team" _delta="must_exist">
  <fields>
    <field id="dashboard" xsi:type="AttributeDashboard" _delta="define">
      <is_user_editable>true</is_user_editable>
      <definition>
        <layout>DashboardLayoutOneCol</layout>
        <title/>
        <auto_reload>
          <enabled>false</enabled>
          <interval>300</interval>
        </auto_reload>
        <cells>
          <cell id="0">
            <rank>0</rank>
            <dashlets>
              <dashlet id="0" xsi:type="DashletEmptyCell">
                <rank>0</rank>
              </dashlet>
            </dashlets>
          </cell>
        </cells>
      </definition>
    </field>
  </fields>
  <presentation>
    <details>
      <items>
        <item id="dashboard" _delta="define">
          <rank>100</rank>
        </item>
      </items>
    </details>
  </presentation>
</class>
```

### 设计仪表盘

先部署一个空仪表盘版本，在 iTop 中直接设计：

1. 使用 `:this->id` 引用当前团队 ID
2. 设计完成后导出为 XML
3. 替换初始 `<definition>` 的内容

示例导出：

```xml
<?xml version="1.0"?>
<dashboard xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <layout>DashboardLayoutOneCol</layout>
  <title/>
  <auto_reload>
    <enabled>false</enabled>
    <interval>300</interval>
  </auto_reload>
  <cells>
    <cell id="0">
      <rank>0</rank>
      <dashlets>
        <dashlet id="1" xsi:type="DashletObjectList">
          <rank>0</rank>
          <title>Members</title>
          <query>SELECT Person AS p 
                 JOIN lnkPersonToTeam AS lnk ON lnk.person_id = p.id 
                 WHERE lnk.team_id=:this->id
          </query>
          <menu>true</menu>
        </dashlet>
      </dashlets>
    </cell>
  </cells>
</dashboard>
```

### 添加字典条目

```xml
<dictionary id="EN US" _delta="must_exist">
  <entries>
    <entry id="Class:Team/Attribute:dashboard" _delta="define">
      <![CDATA[Overview]]>
    </entry>
  </entries>
</dictionary>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:add-dashboard-attribute>

版本：3_2_0/customization/add-dashboard-attribute.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
