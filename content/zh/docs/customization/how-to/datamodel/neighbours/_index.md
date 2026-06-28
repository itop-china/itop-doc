---
title: "定义依赖关系"
linkTitle: "定义依赖关系"
date: 2025-06-27
weight: 10
description: >
  定义依赖关系。
---

{{% pageinfo %}}
本文档介绍如何在 iTop 类之间定义新的依赖关系，用于影响分析。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:neighbours)。
{{% /pageinfo %}}

## 概述

假设创建了 FunctionalCI 下的新类 "Truc"，该类影响 ApplicationSolution 或 BusinessProcess。且影响规则因每个 ApplicationSolution 和 BusinessProcess 而异。

## 实现

```xml
<class id="Truc" _delta="define">
  <parent>FunctionalCI</parent>
  <properties>...</properties>
  <fields>
    <field id="functionalci_id" xsi:type="AttributeExternalKey">
      <sql>functionalci_id</sql>
      <filter><![CDATA[
        SELECT FunctionalCI WHERE finalclass IN ('ApplicationSolution', 'BusinessProcess')
      ]]></filter>
      <target_class>FunctionalCI</target_class>
      <is_null_allowed>true</is_null_allowed>
      <on_target_delete>DEL_MANUAL</on_target_delete>
      <tracking_level>all</tracking_level>
      <allow_target_creation>true</allow_target_creation>
    </field>
  </fields>
  <relations>
    <relation id="impacts">
      <neighbours>
        <neighbour id="business">
          <attribute>functionalci_id</attribute>
        </neighbour>
      </neighbours>
    </relation>
  </relations>
</class>

<class id="FunctionalCI" _delta="merge">
  <fields>
    <field id="trucs_list" xsi:type="AttributeLinkedSet" _delta="define">
      <linked_class>Truc</linked_class>
      <ext_key_to_me>functionalci_id</ext_key_to_me>
      <count_min>0</count_min>
      <count_max>0</count_max>
      <edit_mode>add_remove</edit_mode>
      <duplicates/>
    </field>
    <field id="redundancy" xsi:type="AttributeRedundancySettings" _delta="define">
      <sql>redundancy</sql>
      <relation_code>impacts</relation_code>
      <from_class>Truc</from_class>
      <neighbour_id>business</neighbour_id>
      <enabled>true</enabled>
      <enabled_mode>user</enabled_mode>
      <min_up>1</min_up>
      <min_up_mode>user</min_up_mode>
      <min_up_type>count</min_up_type>
    </field>
  </fields>
</class>

<class id="BusinessProcess" _delta="merge">
  <presentation>
    <details>
      <items>
        <item id="trucs_list" _delta="define">
          <rank>110</rank>
        </item>
      </items>
    </details>
  </presentation>
</class>

<class id="ApplicationSolution" _delta="merge">
  <presentation>
    <details>
      <items>
        <item id="trucs_list" _delta="define">
          <rank>110</rank>
        </item>
      </items>
    </details>
  </presentation>
</class>
```

### 关键点

- `relation id="impacts"` 必须命名为 "impacts" 才能在影响分析中使用
- `neighbour` 的 `attribute` 可以是指向外部键、LinkedSet 或一对查询（向下和向上）
- `AttributeRedundancySettings` 允许配置冗余规则
- `min_up` 定义最少需要多少个 "Truc" 处于运行状态

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:neighbours>

版本：3_2_0/customization/neighbours.txt · Last modified: 2024/09/10 10:25 by 127.0.0.1
