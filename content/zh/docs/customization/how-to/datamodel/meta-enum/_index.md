---
title: "合并状态"
linkTitle: "合并状态"
date: 2025-06-27
weight: 10
description: >
  合并状态。
---

{{% pageinfo %}}
本文档介绍如何使用 AttributeMetaEnum 创建基于子类字段值的合并状态。更多详细内容请参考 [iTop 官方文档](https://www.itophub.io/wiki/page?id=3_2_0:customization:meta-enum)。
{{% /pageinfo %}}

## 概述

Ticket 类使用特殊的 `AttributeMetaEnum` 类型属性来创建聚合状态，基于子工单类字段值自动计算。

您可以为 FunctionalCI 类创建类似的 `AttributeMetaEnum` 字段，基于一个或多个子类上定义的字段值计算。

## 添加计算状态

```xml
<class id="FunctionalCI" _created_in="itop-config-mgmt" _delta="must_exist">
  <fields>
    <field id="operational_status" xsi:type="AttributeMetaEnum" _delta="define">
      <values>
        <value id="production"><code>production</code></value>
        <value id="implementation"><code>implementation</code></value>
        <value id="obsolete"><code>obsolete</code></value>
      </values>
      <sql>operational_status</sql>
      <default_value>production</default_value>
      <mappings>
        <mapping id="FunctionalCI">
          <attcode>status</attcode>
          <metavalues>
            <metavalue id="implementation">
              <values>
                <value id="implementation"/>
              </values>
            </metavalue>
            <metavalue id="obsolete">
              <values>
                <value id="obsolete"/>
                <value id="inactive"/>
              </values>
            </metavalue>
          </metavalues>
        </mapping>
      </mappings>
    </field>
  </fields>
</class>
```

- `default_value`：若没有任何映射适用，则使用此默认值
- `mapping` 的 ID 必须是当前类或子类
- `attcode`：至少一个子类上定义的属性代码
- 可定义多个映射，第一个匹配的映射决定 AttributeMetaEnum 的值

## 修改计算状态

示例：添加新的 `escalated` 值，并修改 UserRequest 的 `rejected` 映射逻辑：

```xml
<field id="operational_status" xsi:type="AttributeMetaEnum">
  <values _delta="must_exist">
    <value id="escalated" _delta="define">
      <code>escalated</code>
    </value>
  </values>
  <mappings>
    <mapping id="Ticket" _delta="must_exist">
      <metavalues>
        <metavalue id="escalated" _delta="define">
          <values>
            <value id="escalated_tto"/>
            <value id="escalated_ttr"/>
          </values>
        </metavalue>
        <metavalue id="closed" _delta="must_exist">
          <values>
            <value id="rejected" _delta="delete"/>
          </values>
        </metavalue>
      </metavalues>
    </mapping>
    <mapping id="Change" _delta="define">
      <attcode>status</attcode>
      <metavalues>
        <metavalue id="closed">
          <values>
            <value id="closed"/>
            <value id="rejected"/>
          </values>
        </metavalue>
      </metavalues>
    </mapping>
  </mappings>
</field>
```

此示例中：
- UserRequest 的 `rejected` 状态映射为 `ongoing`（Ticket 的默认映射）
- Change 的 `rejected` 状态仍映射为 `closed`

## 默认 3.1 定义

```xml
<field id="operational_status" xsi:type="AttributeMetaEnum">
  <values>
    <value id="ongoing">
      <code>ongoing</code>
    </value>
    <value id="resolved">
      <code>resolved</code>
      <style>
        <main_color>$ibo-lifecycle-success-state-primary-color</main_color>
        <complementary_color>$ibo-lifecycle-success-state-secondary-color</complementary_color>
        <decoration_classes>fas fa-check</decoration_classes>
      </style>
    </value>
    <value id="closed">
      <code>closed</code>
      <style>
        <main_color>$ibo-lifecycle-frozen-state-primary-color</main_color>
        <complementary_color>$ibo-lifecycle-frozen-state-secondary-color</complementary_color>
        <decoration_classes/>
      </style>
    </value>
  </values>
  <default_style>
    <main_color>$ibo-lifecycle-neutral-state-primary-color</main_color>
    <complementary_color>$ibo-lifecycle-neutral-state-secondary-color</complementary_color>
    <decoration_classes/>
  </default_style>
  <sql>operational_status</sql>
  <default_value>ongoing</default_value>
  <mappings>
    <mapping id="Ticket">
      <attcode>status</attcode>
      <metavalues>
        <metavalue id="resolved">
          <values>
            <value id="resolved"/>
          </values>
        </metavalue>
        <metavalue id="closed">
          <values>
            <value id="closed"/>
            <value id="rejected"/>
          </values>
        </metavalue>
      </metavalues>
    </mapping>
  </mappings>
</field>
```

---
原文：<https://www.itophub.io/wiki/page?id=3_2_0:customization:meta-enum>

Last modified: 2026/01/14 17:10 by127.0.0.1

版本：3_2_0/customization/meta-enum.txt · Last modified: 2026/01/14 17:10 by 127.0.0.1
